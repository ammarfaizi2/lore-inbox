Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272248AbTHIEst (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 00:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272252AbTHIEst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 00:48:49 -0400
Received: from smtp2.us.dell.com ([143.166.85.133]:65497 "EHLO
	smtp2.us.dell.com") by vger.kernel.org with ESMTP id S272248AbTHIEsr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 00:48:47 -0400
Date: Fri, 8 Aug 2003 23:48:23 -0500 (CDT)
From: Matt Domsch <Matt_Domsch@Dell.com>
X-X-Sender: mdomsch@humbolt.us.dell.com
Reply-To: Matt Domsch <Matt_Domsch@Dell.com>
To: Patrick Mochel <mochel@osdl.org>
cc: Matt Tolentino <metolent@snoqualmie.dp.intel.com>,
       <davidm@napali.hpl.hp.com>, <torvalds@osdl.org>,
       <linux-ia64@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       <matthew.e.tolentino@intel.com>
Subject: Re: [patch] move efivars to drivers/efi
In-Reply-To: <Pine.LNX.4.44.0308081829530.959-100000@cherise>
Message-ID: <Pine.LNX.4.44.0308082344390.17754-100000@humbolt.us.dell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes - have you considered doing a sysfs interface instead of procfs? :)

It's crossed my mind, but I haven't had much time to spend on IA-64 the
past year, and that isn't likely to change soon...  I think the only tool
that uses /proc/efi/vars is efibootmgr, which would also need to learn of
a move to /sys.  Your binary-blob interface for sysfs is exactly the right
thing to use for it though.

Anyone want to take a stab at switching it, or do you want to wait for me
to have time?

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

