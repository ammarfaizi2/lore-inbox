Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262092AbVBQUA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262092AbVBQUA5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 15:00:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262335AbVBQUA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 15:00:26 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:23260 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262333AbVBQUAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 15:00:07 -0500
Date: Thu, 17 Feb 2005 20:56:52 +0100
From: Pavel Machek <pavel@suse.cz>
To: dtor_core@ameritech.net
Cc: John M Flinchbaugh <john@hjsoft.com>, Pavel Machek <pavel@suse.cz>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Swsusp, resume and kernel versions
Message-ID: <20050217195651.GB5963@openzaurus.ucw.cz>
References: <200502162346.26143.dtor_core@ameritech.net> <20050217110731.GE1353@elf.ucw.cz> <20050217162847.GA32488@butterfly.hjsoft.com> <d120d5000502170930ccc3e9e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000502170930ccc3e9e@mail.gmail.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Just remember you're doing the mkswap if you decide to rearrange your
> > partitions at all, or code a script smart enough to grep your swap
> > partitions out of your fstab.
> 
> It could be a workaround. Still it will cause loss of unsaved work if
> I happen to load wrong kernel. Given that the code checking for swsusp
> image can be marked __init I don't understand the reasons gainst doing
> it.

How do you know which partitions to check? swsusp gets it from resume= parameter,
but if you do not have it compiled, you probably have wrong cmdline, too.

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

