Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143385AbREKUJI>; Fri, 11 May 2001 16:09:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143383AbREKUI7>; Fri, 11 May 2001 16:08:59 -0400
Received: from cabal.darkness.net ([204.56.57.2]:44904 "EHLO
	cabal.darkness.net") by vger.kernel.org with ESMTP
	id <S143378AbREKUIp>; Fri, 11 May 2001 16:08:45 -0400
Date: Fri, 11 May 2001 14:08:43 -0600
From: Jeremy <heffner@darkness.net>
To: =?iso-8859-1?Q?Christian_Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
Cc: kernel@llamas.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: Latest on Athlon Via KT133A chipset solution?
Message-ID: <20010511140842.E26029@bletchley.darkness.net>
In-Reply-To: <E14yHQW-0001Sg-00@the-village.bc.nu> <007d01c0da4e$6f37b540$d539e195@boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <007d01c0da4e$6f37b540$d539e195@boeblingen.de.ibm.com>; from linux-kernel@borntraeger.net on Fri, May 11, 2001 at 09:12:30PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just tested the -ac7 with K7 optimizations on.  I see the same behavior of
oopsing right after boot:

[...]
Freeing unused kernel memory: 216k freed
Unable to handle kernel NULL pointer dereference at virtual address
00000000
[...]

Just fine when I go back down to k6-3, et al, optimizations.

Tyan S2380B VIA KT133A, amd 1.33ghz, regular stepping, no OC or anything.

If you want more info, lemme know.

Also had some USB weirdness, but I'm going to debug that a bit before I
report on it.

thx,
-jeremy

Christian Bornträger enlightened recipients with the following on 11May2001:
> > Give the current -ac a spin and tell me if it works/doesnt and if not how
> > it fails
> 
> I will test it on Sunday evening, when I get back access to my Athlon.
> 
> Again I am not sure if I had the same problem related to the
> compiler-optimizations. My problems (system freeze) started with 2.4.3-ac7.
> So the problem might related to the VIA-bug-workaround.
> 
> Is there a possibility to get debugging messages or register dumps without a
> second PC? Or is there a possibility to an unbuffered log write? e.g. write
> kernel logs to a floppy disc unbuffered. Otherwise I am not sure, if I am
> able to help you finding the problem.
> Unfortunately I have only a VIA-based Athlon system and not a S/390


