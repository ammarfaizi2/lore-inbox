Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263976AbTCUULb>; Fri, 21 Mar 2003 15:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263973AbTCUUKf>; Fri, 21 Mar 2003 15:10:35 -0500
Received: from ip68-101-124-193.oc.oc.cox.net ([68.101.124.193]:38797 "EHLO
	ip68-101-124-193.oc.oc.cox.net") by vger.kernel.org with ESMTP
	id <S263846AbTCUUJd>; Fri, 21 Mar 2003 15:09:33 -0500
Date: Fri, 21 Mar 2003 12:20:34 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.65] Broken gcc test
Message-ID: <20030321202034.GA3101@ip68-101-124-193.oc.oc.cox.net>
References: <Pine.LNX.4.44.0303211407180.7786-100000@oddball.prodigy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303211407180.7786-100000@oddball.prodigy.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 21, 2003 at 02:14:16PM -0500, Bill Davidsen wrote:
> It seems that a test for the frame pointer gcc bug was incorrectly added 
> to the build process, rejecting all 2.96 compilers (which generate better 
> code than 3.2) instead of just the broken ones.
[snip]

AFAICT Linus did this intentionally:

http://www.uwsg.iu.edu/hypermail/linux/kernel/0303.1/1031.html

"Yeah, it will get some fixed compilers too, but that's just not worth
worrying about - people will just have to turn off CONFIG_FRAME_POINTER
and be happy."

-Barry K. Nathan <barryn@pobox.com>
