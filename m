Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261744AbULUMGx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbULUMGx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 07:06:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261746AbULUMGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 07:06:53 -0500
Received: from mail.gmx.de ([213.165.64.20]:47540 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261744AbULUMGj (ORCPT
	<rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Tue, 21 Dec 2004 07:06:39 -0500
Date: Tue, 21 Dec 2004 13:06:37 +0100 (MET)
From: "Loic Domaigne" <loic-dev@gmx.net>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: nptl@bullopensource.org, Linux-Kernel@Vger.Kernel.ORG, mingo@elte.hu
MIME-Version: 1.0
References: <41C8047E.1030403@cyberone.com.au>
Subject: Re: OSDL Bug 3770
X-Priority: 3 (Normal)
X-Authenticated: #19395655
Message-ID: <25289.1103630797@www66.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Nick, 

> >Does Linux tolerate hard CPU binding? By hard CPU binding, I mean 
> >that the application tells the scheduler "I want to run there", 
> >and the scheduler schedules the thread(s) "there" regardless if it 
> >makes sense or not ( The decision is left to the application). 
> 
> Yes, it does support hard CPU binding - sched_setaffinity

Yes, I believe that /sched_setaffinity()/ offers a practical solution to the
problem we are faced. 

But I am eager to try the RT-patchset of Ingo. 


> [snip interesting dialogue]
> 
> Thanks for your detailed comments, they were interesting.

... Glad to hear. You're welcome!  



Cheers,  
Loic. 

-- 
--
// Sender address goes to /dev/null (!!) 
// Use my 32/64 bits, ANSI C89, compliant email-address instead:   

unsigned y[]=
{0,34432,26811,16721,41866,63119,61007,48155,26147,10986};
void x(z){putchar(z);}; unsigned t; 
main(i){if(i<10){t=(y[i]*47560)%65521;x(t>>8);x(t&255);main(++i);}}

+++ Sparen Sie mit GMX DSL +++ http://www.gmx.net/de/go/dsl
AKTION für Wechsler: DSL-Tarife ab 3,99 EUR/Monat + Startguthaben
