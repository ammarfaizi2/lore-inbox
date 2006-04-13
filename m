Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964919AbWDMOOq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964919AbWDMOOq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 10:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964904AbWDMOOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 10:14:46 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:24479 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S964919AbWDMOOp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 10:14:45 -0400
Date: Thu, 13 Apr 2006 16:14:36 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Dan Bonachea <bonachead@comcast.net>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: PROBLEM: pthread-safety bug in write(2) on Linux 2.6.x
In-Reply-To: <6.2.5.6.2.20060413015645.033d3fc8@comcast.net>
Message-ID: <Pine.LNX.4.61.0604131613160.17374@yvahk01.tjqt.qr>
References: <6.2.5.6.2.20060412173852.033dbb90@cs.berkeley.edu>
 <20060412214613.404cf49f.akpm@osdl.org> <6.2.5.6.2.20060413015645.033d3fc8@comcast.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> I don't know enough about the kernel implementation to comment on your proposed
> fixes.
>
> However, I should clarify that this problem definitely affects more than just
> "silly testcases", and the fact that a program generates non-deterministically
> ordered output does not necessarily make it erroneous, invalid or unuseful.
>
For example syslogd (in the rare event that it does not use stdio). Or any 
kind of logfile daemon that just dumps incoming events to a file that needs 
user analysis afterwards anyway.


Jan Engelhardt
-- 
