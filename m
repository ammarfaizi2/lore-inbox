Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262465AbRENUOC>; Mon, 14 May 2001 16:14:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262470AbRENUNm>; Mon, 14 May 2001 16:13:42 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:1289 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262465AbRENUNl>; Mon, 14 May 2001 16:13:41 -0400
Subject: Re: LANANA: To Pending Device Number Registrants
To: hpa@transmeta.com (H. Peter Anvin)
Date: Mon, 14 May 2001 21:09:59 +0100 (BST)
Cc: jgarzik@mandrakesoft.com (Jeff Garzik),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List),
        torvalds@transmeta.com (Linus Torvalds), viro@math.psu.edu
In-Reply-To: <3B0038B3.EBB9747A@transmeta.com> from "H. Peter Anvin" at May 14, 2001 12:57:39 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14zOfH-0001LG-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > (c) does not require devfs.  most distros ship without it afaik, and
> > switching to it is not an overnight process, and requires devfsd to be
> > useful in the real world.
> > 
> 
> It does, however, not manage permissions, nor does it provide for a sane
> namespace (it exposes too many internal implementation details in the
> interface -- in particular, the driver becomes part of the namespace, and
> devices move around between drivers regularly.)

It is also very hard to tar that device file.

As to devfsd well Al Viro was reporting races in it long ago that I don't 
believe Richard has had time to fix nor has anyone else fixed. 

What is the state on devfs there ?

