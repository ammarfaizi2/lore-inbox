Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288272AbSAHTow>; Tue, 8 Jan 2002 14:44:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288273AbSAHTon>; Tue, 8 Jan 2002 14:44:43 -0500
Received: from chaos.analogic.com ([204.178.40.224]:25216 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S288272AbSAHTo0>; Tue, 8 Jan 2002 14:44:26 -0500
Date: Tue, 8 Jan 2002 14:45:20 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Anthony DeRobertis <asd@suespammers.org>
cc: jtv <jtv@xs4all.nl>, Jacques Gelinas <jack@solucorp.qc.ca>,
        linux-kernel@vger.kernel.org
Subject: Re: Whizzy New Feature: Paged segmented memory
In-Reply-To: <A7567F5E-046E-11D6-8467-00039355CFA6@suespammers.org>
Message-ID: <Pine.LNX.3.95.1020108143658.2809A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jan 2002, Anthony DeRobertis wrote:

> 
> On Tuesday, January 8, 2002, at 09:14 AM, Richard B. Johnson wrote:
> 
> > At least with Intel ix8*, even though one can create a discriptor for
> > a (backwards) stack, you would have a hard time using it. 
> > 'Push' op-codes
> > decrement the stack-pointer and 'pop' increments it regardless of
> > the characteristics of the stack-selector.
> 
> You'd have to do it manually, without those instructions. That's 
> what you get for using a CISC architecture from who-knows-when.
> 
> I'd guess most RISC architectures don't have this problem.
> 

Yes, and you can choose any one of a zillion registers to address
your "stack" although there are some de-facto standards, not enforced
by the hardware.  But this all comes with trade-offs discussed from
about all perspectives in the past, context-switches come to mind.
Using Intel, with the proper call-frame on the stack, `iret` switches
context. Setting the proper call-frame and saved register values is
easy because there are so few registers!

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


