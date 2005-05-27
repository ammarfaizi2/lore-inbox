Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261330AbVE0FBA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261330AbVE0FBA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 01:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261649AbVE0FBA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 01:01:00 -0400
Received: from mail.toyon.com ([65.160.147.241]:20393 "EHLO mail.toyon.com")
	by vger.kernel.org with ESMTP id S261330AbVE0FAw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 01:00:52 -0400
Message-ID: <013201c56278$fa9fee70$1600a8c0@toyon.corp>
From: "Peter J. Stieber" <developer@toyon.com>
To: "Christopher Warner" <cwarner@kernelcode.com>, <chris@servertogo.com>
Cc: <linux-kernel@vger.kernel.org>, "Bill Davidsen" <davidsen@tmr.com>
References: <3174569B9743D511922F00A0C943142309F815A6@TYANWEB> <037801c5616a$b1be6600$1600a8c0@toyon.corp> <4295E9F1.6080304@tmr.com> <022e01c56233$241e5930$1600a8c0@toyon.corp> <1117156446.8874.41.camel@localhost.localdomain>
Subject: Re: Tyan Opteron boards and problems with parallel ports (badpmd)
Date: Thu, 26 May 2005 22:00:18 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2527
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PJS = Peter J. Stieber
PJS>> I have been having the "memory.c bad pmds" with
PJS>> a Tyan S2885 motherboard.
PJS>>
PJS>> https://www.redhat.com/archives/fedora-list/2005-May/msg01690.html
PJS>> 
http://www.lib.uaa.alaska.edu/linux-kernel/archive/2005-Week-19/1397.html
PJS>>
PJS>> <Skip a lot>
PJS>> I'm just trying anything I can to get rid of the
PJS>> bad pmd messages.

CW=Christopher Warner
CW> Just read the other existing thread linked. Is
CW> everyone running the same model opteron on these
CW> Tyan boards (246)? To update even further. Besides
CW> the parallel port problem I've sent back about 5 of
CW> these tyan motherboards. A couple of then simply
CW> didn't have the gigabit network adapters available
CW> via bios. In some cases linux loaded the drivers for
CW> the adapters regardless of their setting in BIOS. In
CW> other cases they simply were not available.
CW>
CW> Also, are the processes you run swapping out/in memory
CW> repeatedly? Or using a large amount of threading?
CW> Thread pools? I'm trying to get rid of this problem
CW> myself. I've seen it extensively in 2.6.11.5 and not as
CW> much in 2.6.11.8 but I haven't tested lately past .8

I'm running two 244 processors not 246 processors. The process that 
causes problems is a bash shell script that builds a suite of codes. The 
scipt call other scripts that call autoreconfig then call configure and 
the cofigure dies sometimes. If I repeat the process it works. It might 
be swapping/paging related. I'm not sure how I could tell. I normally 
use stock Fedora distributions. I started seeing the problem in April 
after I installed 2.6.11-1.14_FC3smp. I'm currently running 
2.6.11-1.29_FC3smp provided by Dave Jones and I still see the problem.

Pete 


