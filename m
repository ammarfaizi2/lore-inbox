Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269620AbRHADh6>; Tue, 31 Jul 2001 23:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269621AbRHADhq>; Tue, 31 Jul 2001 23:37:46 -0400
Received: from zok.sgi.com ([204.94.215.101]:29608 "EHLO zok.corp.sgi.com")
	by vger.kernel.org with ESMTP id <S269620AbRHADhh>;
	Tue, 31 Jul 2001 23:37:37 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Alan Olsen <alan@clueserver.org>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PCMCIA IDE_CS in 2.4.7 
In-Reply-To: Your message of "Tue, 31 Jul 2001 21:03:45 MST."
             <Pine.LNX.4.10.10107312050460.25753-100000@clueserver.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 01 Aug 2001 13:37:39 +1000
Message-ID: <11314.996637059@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tue, 31 Jul 2001 21:03:45 -0700 (PDT), 
Alan Olsen <alan@clueserver.org> wrote:
>The module that used to be called "ide_cs.o" is now called "ide-cs.o".
>It this on purpose or have I found a bug?

drivers/ide/Makefile was added to the kernel in 2.4.3-99pre on approx.
May 19, 2000.  The module was called ide-cs.o then and has had that
name ever since.  The inconsistency between the kernel and the pcmcia
package is annoying but changing the kernel name now would probably
cause more problems that it solved.

