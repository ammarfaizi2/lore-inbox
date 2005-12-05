Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751457AbVLEUlq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457AbVLEUlq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 15:41:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751458AbVLEUlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 15:41:45 -0500
Received: from fsmlabs.com ([168.103.115.128]:41167 "EHLO spamalot.fsmlabs.com")
	by vger.kernel.org with ESMTP id S1751457AbVLEUlo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 15:41:44 -0500
X-ASG-Debug-ID: 1133815298-5597-34-0
X-Barracuda-URL: http://10.0.1.244:8000/cgi-bin/mark.cgi
Date: Mon, 5 Dec 2005 12:47:15 -0800 (PST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Clemens Koller <clemens.koller@anagramm.de>
cc: linux-kernel@vger.kernel.org, Jeff Collins <jgcc@pacbell.net>
X-ASG-Orig-Subj: Re: 2.6.13.2 crash on shutdown on SMP machine
Subject: Re: 2.6.13.2 crash on shutdown on SMP machine
In-Reply-To: <4394260F.7020703@anagramm.de>
Message-ID: <Pine.LNX.4.64.0512051246130.13220@montezuma.fsmlabs.com>
References: <433A747E.3070705@anagramm.de> <4394260F.7020703@anagramm.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=5.0 KILL_LEVEL=5.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.5985
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Dec 2005, Clemens Koller wrote:

> Hello, Guys, hello, Jeff!
> 
> This issue seems to happen more than once:
> 
> Jeff Collins wrote:
> > I experience a panic whenever I shut down a 4 cpu Intel PII Xeon SMP system.
> 
> What panic do you get?
> 
> > Linux sitka 2.6.14.3 #2 SMP Fri Dec 2 09:01:46 PST 2005 i686 unknown unknown
> > GNU/Linux
> > Base OS: Slackware 10.2
> > Kernel: 2.6.14.3 from kernel.org
> > 
> > "shutdown -h now" causes the panic
> > 
> > "shutdown -r now" reboots correctly.
> 
> I guess it panics, too, but the reboot still works, so you just don't
> see the panic. (?)
> 
> > I got the same panic when I substituted the 2.6.13 kernel.
> 
> Still the same thing over here. Unfortunately, I am pretty busy with other
> work, and the affected system isn't really needed. It's an old
> Tyan Tomcat IIID Mainboard with two Pentium I MMX 200MHz CPU's.
> Theoretically I would be able to test the latest git snapshots, but currently
> it's just not possible. :-(
> Let me know if you cannot solve this issue - maybe I can spend some
> time to give some more information for debugging by the end of this week.

>From what i hear it's this issue;

http://bugzilla.kernel.org/show_bug.cgi?id=5203

Which is being looked at, feel free to chip in though.
