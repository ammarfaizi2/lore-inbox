Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315456AbSFDSWz>; Tue, 4 Jun 2002 14:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315754AbSFDSWy>; Tue, 4 Jun 2002 14:22:54 -0400
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:28420 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S315456AbSFDSWw>; Tue, 4 Jun 2002 14:22:52 -0400
Message-Id: <200206041822.g54IMLiq012827@pincoya.inf.utfsm.cl>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: Jens Axboe <axboe@suse.de>, Neil Brown <neilb@cse.unsw.edu.au>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.20 RAID5 compile error 
In-Reply-To: Message from Martin Dalecki <dalecki@evision-ventures.com> 
   of "Tue, 04 Jun 2002 16:24:17 +0200." <3CFCCD91.4020308@evision-ventures.com> 
Date: Tue, 04 Jun 2002 14:22:21 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dalecki <dalecki@evision-ventures.com> said:
> Well it's kind like the answer to the question: why don't do it all in hand
> optimized assembler? Or in other words - let's give the GCC guys good
> reasons for more hard work. But more seriously:
> 
> Things like unlikely() tricks and other friends seldomly really
> pay off if applied randomly. But they can:
> 
> 1. Have quite contrary effects to what one would expect due to
> the fact that one is targetting a single instruction set but in
> reality multiple very different CPU archs or even multiple archs.
> 
> 2. Changes/improvements to the compiler.
> 
> My personal rule of thumb is - don't do something like the
> above unless you did:
> 
> 1. Some real global profiling.
> 2. Some real CPU cycle counting on the micro level.
> 3. You really have too. (This should be number 1!)

Anybody trying to tune code should read (and learn by heart):

@Book{bentley82:_writing_eff_progr,
  author =	 {Jon Louis Bentley},
  title = 	 {Writing Efficient Programs},
  publisher = 	 {Prentice Hall},
  year = 	 1982
}

(sadly out of print AFAIK)
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513

