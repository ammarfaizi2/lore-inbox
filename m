Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262912AbTHUVBA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 17:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262914AbTHUVBA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 17:01:00 -0400
Received: from zero.aec.at ([193.170.194.10]:39952 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S262912AbTHUVA6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 17:00:58 -0400
To: Chris Meadors <clubneon@hereintown.net>
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: Hang when mounting XFS root in 2.6.0 tests on x86-64
From: Andi Kleen <ak@muc.de>
Date: Thu, 21 Aug 2003 23:00:42 +0200
In-Reply-To: <n4o5.8ga.21@gated-at.bofh.it> (Chris Meadors's message of
 "Thu, 21 Aug 2003 22:40:13 +0200")
Message-ID: <m3r83en2th.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.2 (i586-suse-linux)
References: <n4o5.8ga.21@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Meadors <clubneon@hereintown.net> writes:

Better report it to linux-xfs@oss.sgi.com (cc'ed) too.

> I'm trying to get a 2.6.0-test kernel to boot on my Opteron system.  It
> has SuSE's 2.4.19-SMP kernel on it now, and it boots with that, mounts
> the XFS root just fine.  But I build a vanilla 2.6.0-test3 with no
> module support, everything included that I would need.  The last line
> that it prints during boot is the NET4.0
>
> Repeated presses of Alt+SysRq+P seems to show RIP looping in xfs_xlatesb
> and xfs_lowbit64.
>
> I've tried -test3-bk9 and also went back to -test2 and -test1.
>
> Earlier when playing with this machine I built 2.6.0-test3 with a 32 bit
> only version of gcc, but still optimized for the Opteron.  This one had
> no problem booting and mounting the XFS root.
>
> This is easy to reproduce, so let me know if more information is needed.

I test XFS (but not as root) occasionally on x86-64 and seen no problems 
so far. I haven't tested it with test2+ yet though.

What compiler are you using?

-Andi
