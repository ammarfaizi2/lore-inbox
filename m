Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274850AbRIUVsq>; Fri, 21 Sep 2001 17:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274851AbRIUVsg>; Fri, 21 Sep 2001 17:48:36 -0400
Received: from palrel2.hp.com ([156.153.255.234]:35553 "HELO palrel2.hp.com")
	by vger.kernel.org with SMTP id <S274850AbRIUVsX>;
	Fri, 21 Sep 2001 17:48:23 -0400
Message-ID: <C5C45572D968D411A1B500D0B74FF4A80418D544@xfc01.fc.hp.com>
From: "DICKENS,CARY (HP-Loveland,ex2)" <cary_dickens2@hp.com>
To: "'riel@conectiva.com.br'" <riel@conectiva.com.br>
Cc: "HABBINGA,ERIK (HP-Loveland,ex1)" <erik_habbinga@hp.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: major VM  with 2.4.10pre12 and 2.4.10pre13 and highmem, we  w
	ill help test
Date: Fri, 21 Sep 2001 14:48:18 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik,

I'm working with Erik and need to know which of the 3 patches ( or all )
that you want data for.  We are setting up the plain test right now.

aging
aging+launder
aging2launder

Cary

> -----Original Message-----
> From: HABBINGA,ERIK (HP-Loveland,ex1) 
> Sent: Friday, September 21, 2001 3:10 PM
> To: DICKENS,CARY (HP-Loveland,ex2)
> Subject: FW: major VM suckage with 2.4.10pre12 and 2.4.10pre13 and
> highmem, we will help test
> 
> 
> 
> 
> -----Original Message-----
> From: Rik van Riel [mailto:riel@conectiva.com.br]
> Sent: Friday, September 21, 2001 3:01 PM
> To: HABBINGA,ERIK (HP-Loveland,ex1)
> Cc: 'linux-kernel@vger.kernel.org'
> Subject: Re: major VM suckage with 2.4.10pre12 and 2.4.10pre13 and
> highmem, we will help test
> 
> 
> On Fri, 21 Sep 2001, HABBINGA,ERIK (HP-Loveland,ex1) wrote:
> 
> > Kernel 2.4.10pre13 did not help our NFS SPEC testing on a 
> machine with
> > 4GB RAM.  Refer to my previous message about those results:
> > http://lists.insecure.org/linux-kernel/2001/Sep/3036.html
> >
> > In a nutshell, kswapd starts grabbing 99% of the CPU for long
> > stretches in time, which causes us to drop NFS RPC 
> connections, which
> > causes performance to suck.
> 
> I'm curious, how do recent -ac kernels perform here ?
> 
> If you have the time, could you test 2.4.9-ac13 plain
> and 2.4.9-ac13 with my page aging and launder patches
> from http://www.surriel.com/patches/ ?  ;)
> 
> cheers,
> 
> Rik
> -- 
> IA64: a worthy successor to i860.
> 
> http://www.surriel.com/		http://distro.conectiva.com/
> 
> Send all your spam to aardvark@nl.linux.org (spam digging piggy)
> 
