Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317461AbSFMFi3>; Thu, 13 Jun 2002 01:38:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317462AbSFMFi2>; Thu, 13 Jun 2002 01:38:28 -0400
Received: from eagle.he.net ([216.218.174.2]:7440 "EHLO eagle.he.net")
	by vger.kernel.org with ESMTP id <S317461AbSFMFi2>;
	Thu, 13 Jun 2002 01:38:28 -0400
Date: Wed, 12 Jun 2002 22:38:37 -0700
Message-Id: <200206130538.WAA18419@eagle.he.net>
From: "Anjali Kulkarni" <anjali@indranetworks.com>
To: Richard Zidlicky 
	<Richard.Zidlicky@stud.informatik.uni-erlangen.de>,
        Anjali Kulkarni <anjali@indranetworks.com>, mingo@elte.hu,
        linux-kernel@vger.kernel.org
Subject: Re: scheduler problems
X-Mailer: WebMail 1.25
X-IPAddress: 61.11.16.239
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> > > > [...] It is due to the fact that the schedule() function does 
not 
> > find
> > > > the 'current' process in the runqueue. [...]
> > > 
> > > a crash in line 384 means that the runqueue got corrupted by 
> > something,
> > > most likely caused by buggy kernel code outside of the scheduler.
> > 
> > Right, I thought of that, but how is it that it gets corrupt at 
exactly 
> > the same offset in task_struct of that process and every time with 
> > different processes? (I have run it atleast 20-30 times). And it 
just 
> > doesnt come if I kill the process in question? 
> 
> I've had similar problems when some code invalidated CPU cache 
> and an interrupt came in at the wrong time.
> 

Hi!

I have not very clear on what u mean. Can u explain in more detail?

Thanks,
Anjali

> Richard
> 
> 


Anjali Kulkarni
Software Engineer
Indra Networks

~Living Well is the best Revenge~
