Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262144AbTEUO4a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 10:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262148AbTEUO4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 10:56:30 -0400
Received: from franka.aracnet.com ([216.99.193.44]:59529 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S262144AbTEUO43
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 10:56:29 -0400
Date: Wed, 21 May 2003 08:05:55 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
cc: lse-tech@lists.sourceforge.net, kaos@ocs.com.au,
       James.Bottomley@steeleye.com, mort@wildopensource.com,
       davidm@napali.hpl.hp.com, jun.nakajima@intel.com, tomita@cinet.co.jp
Subject: Re: [Lse-tech] cpu-2.5.69-bk14-1
Message-ID: <11120000.1053529553@[10.10.2.4]>
In-Reply-To: <20030520170331.GK29926@holomorphy.com>
References: <20030520170331.GK29926@holomorphy.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Extended cpumasks for larger systems. Now featuring bigsmp, Summit,
> and Voyager updates in addition to PC-compatible, NUMA-Q, and SN2
> bits from SGI.

Can you remove the random cleanups from this, and just leave the actual
patch please? Things like:

 static inline int apic_id_registered(void)
 {
-       return (1);
+       return 1;
 }
 
... have sweet FA to do with this. If you want to do that, it's a separate
patch.

M.

