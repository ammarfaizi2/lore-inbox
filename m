Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131949AbQKGXrW>; Tue, 7 Nov 2000 18:47:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131889AbQKGXrD>; Tue, 7 Nov 2000 18:47:03 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:36376 "EHLO
	amsmta04-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S131723AbQKGXqM>; Tue, 7 Nov 2000 18:46:12 -0500
Date: Wed, 8 Nov 2000 01:54:02 +0100 (CET)
From: Igmar Palsenberg <maillist@chello.nl>
To: Lyle Coder <x_coder@hotmail.com>
cc: David Schwartz <davids@webmaster.com>, RAJESH BALAN <atmproj@yahoo.com>,
        linux-kernel@vger.kernel.org
Subject: Re: malloc(1/0) ??
In-Reply-To: <OE28zGnClQwSaY2lsLR00001672@hotmail.com>
Message-ID: <Pine.LNX.4.21.0011080151280.32613-100000@server.serve.me.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2000, Lyle Coder wrote:

> When a program does a malloc... the glibc gets atleast on page (brk)
> [actually, glibs determins of it needs to brk more memory from the kernel...
> because it maintains it;s own pool].. so if you malloc 4 byts, you can copy
> to that pointer more than 4 bytes (upto a page size, ex 4K)... hope that
> answers one of your questions... as far as why malloc(0) works... I dunno

Hmm.. Don't read a manpage in the middle of the night.. the issue is only
with realloc(0) that is equal to free().

Maybe one of the glibc guys can tell what the behaviour is with malloc(0).
 
> Best Wishes,
> Lyle


	Igmar

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
