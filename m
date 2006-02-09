Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422646AbWBIJ7U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422646AbWBIJ7U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 04:59:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030513AbWBIJ7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 04:59:20 -0500
Received: from iona.labri.fr ([147.210.8.143]:2988 "EHLO iona.labri.fr")
	by vger.kernel.org with ESMTP id S1030330AbWBIJ7U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 04:59:20 -0500
Date: Thu, 9 Feb 2006 10:59:29 +0100
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: suresh.b.siddha@intel.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Patch] sched: new sched domain for representing multi-core
Message-ID: <20060209095929.GZ4215@implementation.labri.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	suresh.b.siddha@intel.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Could cache-sharing multi-core chips be represented somehow in
/proc/cpuinfo too? Such information can be useful in userspace too
(without having to run cpuid & such). For instance:

physical id	: 0
siblings	: 2
l3 id		: 0
l2 id		: 0
core id		: 0
cpu cores	: 2

etc.

Regards,
Samuel
