Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261740AbSJMUG3>; Sun, 13 Oct 2002 16:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261758AbSJMUG3>; Sun, 13 Oct 2002 16:06:29 -0400
Received: from goose.mail.pas.earthlink.net ([207.217.120.18]:30616 "EHLO
	goose.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S261740AbSJMUG3>; Sun, 13 Oct 2002 16:06:29 -0400
Date: Sun, 13 Oct 2002 13:05:59 -0700 (PDT)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: phil <phil@research.suspicious.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: tridentfb.c, kernel 2.5.38, compile error
In-Reply-To: <20020922222029.54ae9967.phil@research.suspicious.org>
Message-ID: <Pine.LNX.4.33.0210131305330.5997-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> this happens on compile:
>
> gcc -Wp,-MD,./.tridentfb.o.d -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6 -I/usr/src/linux/arch/i386/mach-generic -nostdinc -iwithprefix include    -DKBUILD_BASENAME=tridentfb   -c -o tridentfb.o tridentfb.c
> tridentfb.c:64: field `gen' has incomplete type
> tridentfb.c: In function `trident_set_disp':

API changes. Wil be fixes in the next couple of changesets.

