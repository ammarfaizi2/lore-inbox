Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317157AbSEXPxX>; Fri, 24 May 2002 11:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314457AbSEXPxW>; Fri, 24 May 2002 11:53:22 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:2829 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S317157AbSEXPxT>; Fri, 24 May 2002 11:53:19 -0400
Subject: Re: Quota patches
To: dalecki@evision-ventures.com (Martin Dalecki)
Date: Fri, 24 May 2002 17:12:05 +0100 (BST)
Cc: hch@infradead.org (Christoph Hellwig), alan@lxorguk.ukuu.org.uk (Alan Cox),
        jack@suse.cz (Jan Kara), nathans@sgi.com (Nathan Scott),
        torvalds@transmeta.com (Linus Torvalds),
        hirofumi@mail.parknet.co.jp (OGAWA Hirofumi),
        linux-kernel@vger.kernel.org
In-Reply-To: <3CEE51A4.9010308@evision-ventures.com> from "Martin Dalecki" at May 24, 2002 04:43:48 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17BHfh-0006lp-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Of course you can.  Even the latest OpenLinux release (shipping 2.4.13-ac)
> > uses a libc4/a.out based installer fo space reasons.  Not to forget the
> > old quake1 binary from some redhat 4.x CD I run from time to time :)
> 
> OK thanks for the *substantial* answer. That was the reason I was asking about.
> Somehow this is of course surprising me of course.

So why didn't you -test- the theory before suggesting it. It btw goes beyond
Libc4. Currently we have almost 100% compatibility back to libc 2.2.2. The
dated libc before that doesn't work because we dropped some very very
early obscure versions of a few syscalls.

Is it too much to ask that you go and look through the syscall tables of
old and new kernels ? 

Alan
