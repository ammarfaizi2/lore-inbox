Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276135AbRJ2QQW>; Mon, 29 Oct 2001 11:16:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276132AbRJ2QQL>; Mon, 29 Oct 2001 11:16:11 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:36879 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S276099AbRJ2QQH>; Mon, 29 Oct 2001 11:16:07 -0500
Message-Id: <200110291615.f9TGFYYY010564@pincoya.inf.utfsm.cl>
To: Andreas Dilger <adilger@turbolabs.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] random.c bugfix 
In-Reply-To: Message from Andreas Dilger <adilger@turbolabs.com> 
   of "Sun, 28 Oct 2001 22:37:54 PDT." <20011028223754.G1311@lynx.no> 
Date: Mon, 29 Oct 2001 13:15:33 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger <adilger@turbolabs.com> said:

[...]

> (*) I don't know enough about the hash functions to know how to add a
>     few odd bytes into the store in a useful and safe way.  We don't
>     really want to discard them either - think if a user-space random
>     daemon on an otherwise entropy-free system only writes one byte at
>     a time...

I'm no expert either, but padding with anything (zeroes?) to get the right
length should be safe, no?
-- 
Dr. Horst H. von Brand                Usuario #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
