Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317228AbSEXR56>; Fri, 24 May 2002 13:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317230AbSEXR55>; Fri, 24 May 2002 13:57:57 -0400
Received: from loewe.cosy.sbg.ac.at ([141.201.2.12]:50863 "EHLO
	loewe.cosy.sbg.ac.at") by vger.kernel.org with ESMTP
	id <S317228AbSEXR5N>; Fri, 24 May 2002 13:57:13 -0400
Date: Fri, 24 May 2002 19:57:02 +0200 (MET DST)
From: "Thomas 'Dent' Mirlacher" <dent@cosy.sbg.ac.at>
To: "David S. Miller" <davem@redhat.com>
cc: alan@lxorguk.ukuu.org.uk, tori@ringstrom.mine.nu, imipak@yahoo.com,
        linux-kernel@vger.kernel.org
Subject: Re: Linux crypto?
In-Reply-To: <20020524.103104.107001160.davem@redhat.com>
Message-ID: <Pine.GSO.4.05.10205241955480.11037-100000@mausmaki.cosy.sbg.ac.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 May 2002, David S. Miller wrote:

>    From: "Thomas 'Dent' Mirlacher" <dent@cosy.sbg.ac.at>
>    Date: Fri, 24 May 2002 19:42:45 +0200 (MET DST)
>    
>    what about taking out the libdes stuff, and make it available from
>    elsewhere, and hook it into the kernel as a module?
>    the main kernel could come with a null crypto implementation - which
>    makes no sense to use, but it will allow to meintain the whole system
>    without having to worry about the crypto stuff per se (this shouldn't
>    change very much in any case)
> 
> The US laws cover even things that are meant to allow crypto.

well, but if you take that by the word, is means you cannot export _any_
hooks from the kernel (like the sycall table), because it would enable
someone to place some crytography in there (thinking of read and write
calls)

	tm
-- 
in some way i do, and in some way i don't.

