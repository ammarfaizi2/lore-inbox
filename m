Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289272AbSBJE3r>; Sat, 9 Feb 2002 23:29:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289277AbSBJE3i>; Sat, 9 Feb 2002 23:29:38 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33555 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S289272AbSBJE3W>;
	Sat, 9 Feb 2002 23:29:22 -0500
Message-ID: <3C65F6E9.C505503F@zip.com.au>
Date: Sat, 09 Feb 2002 20:28:25 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        Hugh Dickins <hugh@veritas.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] BUG preserve registers
In-Reply-To: <3C659D8A.37EA0155@zip.com.au> from "Andrew Morton" at Feb 09, 2002 02:07:06 PM <E16Zjw9-0000Dr-00@the-village.bc.nu> <3C65F523.FDDB7FA@zip.com.au> <3C65F5B3.5010006@zytor.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" wrote:
> 
> > non-verbose BUG:
> >         2589971  293436  373404 3256811  31b1eb vmlinux
> > verbose BUG:
> >         2709055  293436  373404 3375895  338317 vmlinux
> > Patched:
> >         2694537  293436  373404 3361377  334a61 vmlinux
> >
> > Which is 100k, which is preposterous.
> >
> 
> Use "size" to determine the actual size, or strip the binary.
> 

That is the output from /usr/bin/size

-
