Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266453AbUAODlV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 22:41:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266450AbUAODlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 22:41:21 -0500
Received: from ms-smtp-02.texas.rr.com ([24.93.47.41]:59617 "EHLO
	ms-smtp-02-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S266453AbUAODlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 22:41:14 -0500
Date: Wed, 14 Jan 2004 21:40:34 -0600 (CST)
From: Matt Domsch <Matt_Domsch@dell.com>
X-X-Sender: mdomsch@iguana.domsch.com
To: davidm@hpl.hp.com
cc: Andrew Morton <akpm@osdl.org>,
       Matt Tolentino <metolent@snoqualmie.dp.intel.com>,
       <davidm@napali.hpl.hp.com>, <linux-ia64@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>, <matthew.e.tolentino@intel.com>
Subject: Re: [patch] efivars update for 2.6.1
In-Reply-To: <16389.51280.731508.513970@napali.hpl.hp.com>
Message-ID: <Pine.LNX.4.44.0401142137540.24355-100000@iguana.domsch.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Matt is the owner of efivars so if he is OK with it, that's fine with
> me.  My only request is that if/when the patch is accepted that there
> is some documentation that makes it clear where one can can get an
> updated/matching efibootmgr from.

Andrew found a spinlock use bug in efivars_exit that needs to get fixed 
first.  Then I'm fine with it.

efibootmgr 0.5.0-test1 is available at 
http://domsch.com/linux/ia64/efibootmgr/testing/efibootmgr-0.5.0-test1.tar.gz

which supports both /proc-style and sysfs-style accesses.  With additional 
feedback that it works as expected for several people, I'll remove the 
'test' moniker.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

