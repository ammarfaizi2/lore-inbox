Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268980AbTBWWSZ>; Sun, 23 Feb 2003 17:18:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268981AbTBWWSZ>; Sun, 23 Feb 2003 17:18:25 -0500
Received: from 251.017.dsl.syd.iprimus.net.au ([210.50.55.251]:56534 "EHLO
	file1.syd.nuix.com.au") by vger.kernel.org with ESMTP
	id <S268980AbTBWWSX> convert rfc822-to-8bit; Sun, 23 Feb 2003 17:18:23 -0500
Content-Type: text/plain; charset=US-ASCII
From: Song Zhao <song.zhao@nuix.com.au>
Reply-To: song.zhao@nuix.com.au
Organization: Nuix
To: Mark Hahn <hahn@physics.mcmaster.ca>
Subject: Re: Supermicro X5DL8-GG (ServerWorks Grandchampion LE chipset) slow
Date: Mon, 24 Feb 2003 09:28:07 -0500
User-Agent: KMail/1.4.3
References: <Pine.LNX.4.44.0302221437250.2686-100000@coffee.psychology.mcmaster.ca>
In-Reply-To: <Pine.LNX.4.44.0302221437250.2686-100000@coffee.psychology.mcmaster.ca>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200302240928.07841.song.zhao@nuix.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Feb 2003 02:43 pm, you wrote:
> > >  > 10x 120GB WD HDD, ServerWorks Grand Champion LE.
> > >  > I am running RH7.3 with 2.4.20 kernel. The performance of this box
> > >  > is about half of an almost identical box (Supermicro X5DP8-G2 mobo,
> > >  > E7501
>
> well, I've rarely seen anyone claiming good performance for any SW chipset,
> especially compared to i75xx's.

I wonder where the problem lies? Is it hardware/software?

>
> > Here is a rough comparison of E7500, E7501 and the ServerWorks Chipset:
>
> I don't really understand the column headed "E7500E7501".  which is it?
> 7500 (dual PC1600) or 7501 (dual pc2100)?
>
> > | Benchmark 				| E7500E7501 	| ServerWorks 	| GrandChampion LE 	|
> >
> > =========================================================================
> >=
> >
> > | Nbench (integer index) 		| 33.47 		| 38.78 		| 10.61 			|
>
> oh, maybe the headers are just broken?  I can readily believe that

You are right, the header is broken. 

> 7500 is 33, 7501 is a little higher, and GCLE is a lot lower.
> remember that this benchmark spends most of its time in strcpy/strcmp...
>
> hmm, I'd be curious to see whether lmbench indicates the GCLE's memory
> latency is much higher than Intel's.  your hdparm -t score indicates that
> the GCLE doesn't have a memory *bandwidth* problem.

Yeah, I noticed that too, buffer cache read is pretty impressive actually. 

I haven't had a chance to run lmbench as it takes about 5 hours to complete. 
Will probably do it within these couple of days. 

