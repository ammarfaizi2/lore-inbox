Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264290AbTLBDVz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 22:21:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264292AbTLBDVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 22:21:55 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:48902 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S264290AbTLBDVw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 22:21:52 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (Bill Davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: Random SIGSEGVs and 2.6.0-test10
Date: 2 Dec 2003 03:10:42 GMT
Organization: I need to put my ORGANIZATION here.
Message-ID: <bqgvri$8mh$1@gatekeeper.tmr.com>
References: <3FC559AB.7000806@sh0n.net>
X-Trace: gatekeeper.tmr.com 1070334642 8913 192.168.12.62 (2 Dec 2003 03:10:42 GMT)
X-Complaints-To: abuse@tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3FC559AB.7000806@sh0n.net>, Shawn Starr  <spstarr@sh0n.net> wrote:
>It's funny you mention random userland SIGSEGV's.
>
>I don't know if this some of the fallout wrt CONFIG_PREEMPT being 
>enabled or not but using vmware and running my ncurses mp3 player seems 
>to trigger an oddity:
>
>Apon using vmware, it may sometimes crap out with a internal bug # and 
>in doing so, sometimes my mp3 player will segfault for no reason. This 
>randomly happens. I do have preempt enabled. Even more odd is the fact 
>that even if I have only say 4500K left out of 576MB, there is 0 swap 
>usage. The kernel malloc fails if there is no physical memory? If I have 
>a huge swap file/disk wouldn't it malloc some of that virtual memory? 
>There is no OOM kill either happening since there's no log of that from 
>the kernel saying it did an OOM kill.
>
>I would certainly like to debug any weird oddities. My systems seem to 
>be good test grounds for such things :-)

1 - You can play with swappiness which should get swap used
2 - I doubt that's the problem
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
