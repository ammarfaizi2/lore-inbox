Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272917AbTHPXlJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 19:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272942AbTHPXlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 19:41:09 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59576 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S272917AbTHPXlH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 19:41:07 -0400
Date: Sun, 17 Aug 2003 00:41:04 +0100
From: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
To: Doug McNaught <doug@mcnaught.org>
Cc: "David D. Hagood" <wowbagger@sktc.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Dumb question: Why are exceptions such as SIGSEGV not logged
Message-ID: <20030816234104.GF710@gallifrey>
References: <200308170410.30844.mhf@linuxmail.org> <200308162049.h7GKnwnP024716@turing-police.cc.vt.edu> <3F3EB8FA.1080605@sktc.net> <m3oeypb3au.fsf@varsoon.wireboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3oeypb3au.fsf@varsoon.wireboard.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.6.0-test3 (i686)
X-Uptime: 00:34:20 up 13:06,  1 user,  load average: 0.12, 0.12, 0.17
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Doug McNaught (doug@mcnaught.org) wrote:
> 
> You can still DoS by forking repeatedly and having the child die with
> SEGV...
> 

True - but there are a million and one ways of similarly DoSing a box;
an option to log programs terminated by a bad uncaught signal would seem
useful to me; at least one of which could be as a sign of someone trying
out buffer overrun type attacks on a system; and just as a diagnostic
to catch apps that go pop when you aren't expecting them too.

(I seem to remember ARM Linux actually does log user exceptions and very
useful it is too).

Dave
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
