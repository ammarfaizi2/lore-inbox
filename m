Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269509AbTHQMma (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 08:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269578AbTHQMma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 08:42:30 -0400
Received: from natsmtp01.webmailer.de ([192.67.198.81]:24566 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S269509AbTHQMm3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 08:42:29 -0400
Message-ID: <3F3F7878.1000202@softhome.net>
Date: Sun, 17 Aug 2003 14:43:36 +0200
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Doug McNaught <doug@mcnaught.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Dumb question: Why are exceptions such as SIGSEGV not logged
References: <lg0i.6yo.11@gated-at.bofh.it> <lgjJ.6Oo.5@gated-at.bofh.it> <lilr.p2.7@gated-at.bofh.it> <livc.wX.17@gated-at.bofh.it>
In-Reply-To: <livc.wX.17@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug McNaught wrote:
> 
> You can still DoS by forking repeatedly and having the child die with
> SEGV...
> 

   We had a problems with synchronization between CPU and memory.
   But the problem was showing up us random crashes of applications with 
SIGSEGV and (rarely) SIGILL.

   But still to prove bug is not in Linux kernel and not in software we 
have killed three weeks, just to find out that Motorola has forgotten to 
publish one errata for their CPU.

   Probably to have an option to log this kind of signals would be 
useful. Because just blindly killing applications - is not correct too.

   I will vote for 'if unhandled -> log it' ;-)

