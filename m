Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273870AbRIXMfo>; Mon, 24 Sep 2001 08:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273877AbRIXMfg>; Mon, 24 Sep 2001 08:35:36 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:6416 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S273870AbRIXMf3> convert rfc822-to-8bit; Mon, 24 Sep 2001 08:35:29 -0400
Date: Mon, 24 Sep 2001 08:12:20 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Jacek =?iso-8859-2?Q?Pop=B3awski?= <jpopl@interia.pl>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: __alloc_pages: 0-order allocation failed
In-Reply-To: <20010924040208.A624@localhost.localdomain>
Message-ID: <Pine.LNX.4.21.0109240810300.1593-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 24 Sep 2001, Jacek [iso-8859-2] Pop³awski wrote:

> I just installed 2.4.10, and...
> 
> __alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c0126c2e
> __alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c0126c2e
> __alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c0126c2e
> VM: killing process donkey_s
> __alloc_pages: 0-order allocation failed (gfp=0x1f0/0) from c0126c2e
> __alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c0126c2e
> VM: killing process screen
> __alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c0126c2e
> VM: killing process bash
> (...)
> 
> I am changing kernels often, but never seen that kind of message. Last kernel I
> had before 2.4.10 was 2.4.10-pre4.
> 
> PS. donkey_s is application which eats a lot of memory, but I have 384MB RAM
> and 100MB swap.

Jacek, 

You had available swap when the VM started to kill processes ? 

