Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262644AbVGMOLJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262644AbVGMOLJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 10:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262645AbVGMOLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 10:11:08 -0400
Received: from rproxy.gmail.com ([64.233.170.194]:50589 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262644AbVGMOLI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 10:11:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CMWIq2frNBMNaH/VjNabv5R/vwGon4dWgrZnVzemkbXV03HRRt9xrC0EhQa2RrvCLHzG1G4LqH4wFtguvMwvwOKxJT9pDHH7mL20FD9Zm3DII+Z5fm8b5lIHXYJLhtCTKd/gHuPJj+wwJpkfmORCyimFFxXZYLAer4x6oTOklY8=
Message-ID: <d120d50005071307116fed5f0e@mail.gmail.com>
Date: Wed, 13 Jul 2005 09:11:07 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] Amiga joystick typo (was: Re: Input: fix open/close races in joystick drivers - add a semaphore)
Cc: Dmitry Torokhov <dtor@mail.ru>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0507131254590.5536@anakin>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200506280052.j5S0qDQT010792@hera.kernel.org>
	 <Pine.LNX.4.62.0507131254590.5536@anakin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/13/05, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Mon, 27 Jun 2005, Linux Kernel Mailing List wrote:
> > tree 11d80109ddc2f61de6a75a37941346100a67a0d1
> > parent af246041277674854383cf91b8f0b01217b521e8
> > author Dmitry Torokhov <dtor_core@ameritech.net> Sun, 29 May 2005 12:29:52 -0500
> > committer Dmitry Torokhov <dtor_core@ameritech.net> Sun, 29 May 2005 12:29:52 -0500
> >
> > Input: fix open/close races in joystick drivers - add a semaphore
> >        to the ones that register more than one input device.
> >
> > Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> >
> >  drivers/input/joystick/amijoy.c     |   29 ++++++++++++++++-------------
> 
> This patch broke compilation of amijoy. Trivial fix below.
> 

Sorry about that. Question - if I were to build a cross-compiler for
amiga what arch is that? Right now I am "compiling" for i386 and hope
that I will catch some real errors in between complaints about missing
include files and definitions...

-- 
Dmitry
