Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265654AbRFXAQn>; Sat, 23 Jun 2001 20:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265664AbRFXAQd>; Sat, 23 Jun 2001 20:16:33 -0400
Received: from Expansa.sns.it ([192.167.206.189]:56588 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S265654AbRFXAQY>;
	Sat, 23 Jun 2001 20:16:24 -0400
Date: Sun, 24 Jun 2001 02:16:01 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "D. Stimits" <stimits@idcomm.com>,
        kernel-list <linux-kernel@vger.kernel.org>
Subject: Re: Is this part of newer filesystem hierarchy?
In-Reply-To: <E15Dx9t-0005zT-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0106240210540.29573-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The point was that Stimits says that on its Red Hat 7.1 he has no
ldscripts directory, and so no files like elf_i386.x and so on.
I was just surprised, since i know thay are all necessary to /usr/bin/ld
to work.

Then he was alo wondering why he has
two libc
/lib/libc.so.6 and /lib/i686/libc.so.6, one is tripped and the other
contains debug symbols.
I can figure why, but he adfirms that /lib/i686 is not included in
/etc/ld.so.conf, there is no preload configured, but this is the directory
used by the loader to find the libc to load.

I have to red hat installed, so i was trying to figure out how things are
working on new releases (my last red hat was 6.2 when i was working at red
hat Italy).

Bests
Luigi

On Sun, 24 Jun 2001, Alan Cox wrote:

> > glad to know this, i do wonder how does /usr/bin/ld work for red hat.
> > to my old mentality this seems red hat is going out of any resonable
> > standard.
>
> It works like /usr/bin/ld on any other platform I know of
>
> > if the same libc stripped would not run library, and they HAVE to mantein
> > a libc.so.6 linside of /lib, otherway this would be too mutch against
> > a resonable standard.
>
> bash-2.04$ ls -l /lib/libc.so.6
> lrwxrwxrwx    1 root     root           13 May 14 16:46 /lib/libc.so.6 -> libc-2.2.2.so
>
> I don't follow the discussion here.
>

