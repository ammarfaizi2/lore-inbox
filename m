Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268344AbUHXVvr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268344AbUHXVvr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 17:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268359AbUHXVvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 17:51:47 -0400
Received: from 209-128-98-078.bayarea.net ([209.128.98.78]:653 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S268344AbUHXVsm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 17:48:42 -0400
Message-ID: <412BB7AE.7050804@zytor.com>
Date: Tue, 24 Aug 2004 14:48:30 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.9-rc1
References: <Pine.LNX.4.58.0408240031560.17766@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0408240031560.17766@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Ok,
>  tons of patches merged, with me being away for a week, and also the
> normal pent-up patch demand after any stable kernel. Special thanks as
> always to Andrew, who synced up 200+ patches (he's attributed in the
> sign-off lines, but not in the appended shortlog, so I just wanted to
> point that out).
> 
> Changes all over: arm, ppc, sparc, acpi, i2c, usb, fbcon, ntfs, xfs, nfs,
> cpufreq, agp, sata, network drivers - you name it. Most of the changes are
> fairly small, but there's a lot of them.
> 
> Administrative trivia, and one thing I agonized over: should I make the
> patches relative to 2.6.8 or 2.6.8.1? I decided that since there is
> nothing that says that a "basic bug-fix" releases for a previous release
> might not happen _after_ we've done a -rc release for the next version, I
> can't sanely do patches against a bugfix release.
> 
> Thus the 2.6.9-rc1 patch is against plain 2.6.8. If you have 2.6.8.1, you
> need to undo the .1 patch, and apply the big one. BK users and tar-balls 
> don't see that particular confusion, of course ;)
> 

The kernel.org scripts I am pretty sure will assume 2.6.9-rc1 are against 
2.6.8, not 2.6.8.1.

	-hpa
