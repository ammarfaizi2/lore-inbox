Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261692AbUK2MDO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261692AbUK2MDO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 07:03:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261696AbUK2MDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 07:03:13 -0500
Received: from smtp-vbr8.xs4all.nl ([194.109.24.28]:8969 "EHLO
	smtp-vbr8.xs4all.nl") by vger.kernel.org with ESMTP id S261692AbUK2MDE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 07:03:04 -0500
Date: Mon, 29 Nov 2004 13:02:59 +0100
From: Jurriaan <thunder7@xs4all.nl>
To: Jakob Oestergaard <jakob@unthought.net>, linux-kernel@vger.kernel.org
Subject: Re: raid1 oops in 2.6.9 (debian package 2.6.9-1-686-smp)
Message-ID: <20041129120259.GA23970@middle.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
References: <20041128142840.GA4119@mur.org.uk> <20041129100707.GX4469@unthought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041129100707.GX4469@unthought.net>
X-Message-Flag: Still using Outlook? As you can see, it has some errors.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakob Oestergaard <jakob@unthought.net>
Date: Mon, Nov 29, 2004 at 11:07:08AM +0100
> Why oh why, do we need raid10 ?

Raid-10 allows things currently not possible with raid-0/raid-1, like
spreading 2 pieces of data over 3 pieces of harddisk.

Their was an introductory message on the linux-raid mailinglist, but
it's more than one month old so I don't have a local copy.

> And; if raid10 does not provide new functionality that was not possible
> with raid1 + raid0, why oh why does this get accepted in a stable kernel
> series? 

New drivers that are not enabled by default have always been allowed in
stable kernels, since they don't have an impact on stability for the
average user.

My $0.02,
Jurriaan
-- 
If something was not wrong things would not be right.
        Sergeant Ortega - Zorro
Debian (Unstable) GNU/Linux 2.6.10-rc2-mm3 2x6078 bogomips load 1.44
