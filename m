Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262163AbREQA3W>; Wed, 16 May 2001 20:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262166AbREQA3M>; Wed, 16 May 2001 20:29:12 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:22798 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262163AbREQA24>; Wed, 16 May 2001 20:28:56 -0400
Subject: Re: LANANA: To Pending Device Number Registrants
To: rgooch@ras.ucalgary.ca (Richard Gooch)
Date: Thu, 17 May 2001 01:24:24 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        rgooch@ras.ucalgary.ca (Richard Gooch),
        geert@linux-m68k.org (Geert Uytterhoeven),
        ingo.oeser@informatik.tu-chemnitz.de (Ingo Oeser),
        torvalds@transmeta.com (Linus Torvalds),
        neilb@cse.unsw.edu.au (Neil Brown),
        jgarzik@mandrakesoft.com (Jeff Garzik),
        hpa@transmeta.com (H. Peter Anvin),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List),
        viro@math.psu.edu
In-Reply-To: <200105162358.f4GNwll13400@vindaloo.ras.ucalgary.ca> from "Richard Gooch" at May 16, 2001 05:58:47 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E150Baa-0004kJ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes, it's broken if someone writes a cabbage dicer driver and uses
> "cd" as the leaf node name for devfs.
> 
> Yes, it's broken if someone writes a cabbage dicer driver and uses
> the same major as the IDE CD-ROM or SCSI CD-ROM drivers.

The difference is one is a kernel interface magic cookie (be it a variable
length one with a 7bit ascii mapping that happens to relate to it, or a 
short constnt) the other is user policy and has no business being set in a
spec
