Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262568AbRENXAg>; Mon, 14 May 2001 19:00:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262562AbRENXA0>; Mon, 14 May 2001 19:00:26 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:20491 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262554AbRENXAJ>; Mon, 14 May 2001 19:00:09 -0400
Subject: Re: LANANA: To Pending Device Number Registrants
To: viro@math.psu.edu (Alexander Viro)
Date: Mon, 14 May 2001 23:55:37 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        torvalds@transmeta.com (Linus Torvalds),
        jgarzik@mandrakesoft.com (Jeff Garzik),
        hpa@transmeta.com (H. Peter Anvin),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <Pine.GSO.4.21.0105141852140.19333-100000@weyl.math.psu.edu> from "Alexander Viro" at May 14, 2001 06:53:10 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14zRFZ-0001dI-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > And lilo ?
> 
> LILO uses BIOS, for fsck sake. It couldn't care less for device numbers
> on the kernel side. Ask Andries how much do they have in common with
> BIOS drive numbers.

grep MAJOR lilo-21.4.4/*|wc -l
    323

Also hdparm
raidtools
psmisc
mtools
mt-st
gpm
joystick

and that is a simple grep of BUILD/*/*.c on RH 7.0. Im not even looking deeper
into subdirectories or powertools or anything like a full debian archive



