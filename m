Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264855AbUDWPjI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264855AbUDWPjI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 11:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264854AbUDWPjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 11:39:07 -0400
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:39622 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S264855AbUDWPjF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 11:39:05 -0400
Date: Fri, 23 Apr 2004 17:39:03 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Allen Martin <AMartin@nvidia.com>
Cc: Len Brown <len.brown@intel.com>, Jamie Lokier <jamie@shareable.org>,
       ross@datscreative.com.au,
       =?iso-8859-1?Q?Christian_Kr=F6ner?= 
	<christian.kroener@tu-harburg.de>,
       Linux-Nforce-Bugs <Linux-Nforce-Bugs@exchange.nvidia.com>,
       linux-kernel@vger.kernel.org
Subject: RE: IO-APIC on nforce2 [PATCH]
In-Reply-To: <DCB9B7AA2CAB7F418919D7B59EE45BAF49FBD4@mail-sc-6-bk.nvidia.com>
Message-ID: <Pine.LNX.4.55.0404231734360.14494@jurand.ds.pg.gda.pl>
References: <DCB9B7AA2CAB7F418919D7B59EE45BAF49FBD4@mail-sc-6-bk.nvidia.com>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Apr 2004, Allen Martin wrote:

> The 8254 PIT is hardwared to IRQ0 on all nForce chipsets, it can't be routed.

 Thanks for this info.  Thus the workaround can be unconditional.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
