Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265754AbRGOCzg>; Sat, 14 Jul 2001 22:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265771AbRGOCzZ>; Sat, 14 Jul 2001 22:55:25 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:59149 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S265754AbRGOCzU>;
	Sat, 14 Jul 2001 22:55:20 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Jesper Juhl <juhl@eisenstein.dk>
cc: linux-kernel@vger.kernel.org
Subject: Re: FYI: asm/amigahw.h: No such file or directory (2.4.7-pre6) 
In-Reply-To: Your message of "Sun, 15 Jul 2001 06:46:44 +0200."
             <3B512034.7080903@eisenstein.dk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 15 Jul 2001 12:54:36 +1000
Message-ID: <14960.995165676@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Jul 2001 06:46:44 +0200, 
Jesper Juhl <juhl@eisenstein.dk> wrote:
>| /sbin/genksyms  -k 2.4.7 > 
>/usr/src/linux-2.4.7-pre6/include/linux/modules/zorro.ver.tmp
>zorro.c:20: asm/amigahw.h: No such file or directory

Ignore it.  zorro is m68k/ppc only but make dep is too dumb to know
that.  The generic problem of make dep reading too many files will be
fixed in 2.5.

