Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269303AbRGaOPl>; Tue, 31 Jul 2001 10:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269306AbRGaOPb>; Tue, 31 Jul 2001 10:15:31 -0400
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:63498 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S269303AbRGaOPX>; Tue, 31 Jul 2001 10:15:23 -0400
Message-Id: <200107311415.f6VEF9oD028247@pincoya.inf.utfsm.cl>
To: Gareth Hughes <gareth.hughes@acm.org>
cc: paulr <reichp@ameritech.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.7 -- GCC-3.0 -- "multiline string literals deprecated" -- PATCH 
In-Reply-To: Message from Gareth Hughes <gareth.hughes@acm.org> 
   of "Tue, 31 Jul 2001 23:52:56 +1000." <3B66B838.C8B427B1@acm.org> 
Date: Tue, 31 Jul 2001 10:15:09 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Gareth Hughes <gareth.hughes@acm.org> said:

[...]

> Yes, unfortunately GCC 3.0 deprecated multiline string literals 

AFAIU, they are non-standard, and can easily hide bugs (in opening a string
and forgetting to close you are in escence commenting out lines of code)

>                                                                 -- I saw
> someone arguing on the GCC mailing lists that writing large chunks of
> inline asm shouldn't be "easy",

Right. If you use a compiler, you shouldn't need it much. Better make
other, more important, things easy/more foolproof, even at some cost for
the asm() writer. (Hint: Count the lines of asm in the kernel (an
_extremely_ heavy asm user!) vs the lines of plain C)

>                                 as it interferes with the compiler's
> optimization passes.  There were other such braindead arguments
> supporting the deprecation. 

Yep, this is a braindead argument. There must have been others (sensible
ones)... 
 
>                             The thread should be pretty easy to find in
> the archives.  Don't know if the deprecation will be removed in future
> versions.

I hope they disallow multiline strings pretty soon.
-- 
Dr. Horst H. von Brand                Usuario #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
