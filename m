Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129387AbQLFTOU>; Wed, 6 Dec 2000 14:14:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129969AbQLFTOK>; Wed, 6 Dec 2000 14:14:10 -0500
Received: from natmail2.webmailer.de ([192.67.198.65]:8126 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S129387AbQLFTN6>; Wed, 6 Dec 2000 14:13:58 -0500
From: Nils Faerber <nils@kernelconcepts.de>
Organization: kernel concepts
To: scole@lanl.gov, Steven Cole <scole@lanl.gov>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.4.0-test12-pre4 + cs46xx + KDE 2.0 = frozen system
Date: Wed, 6 Dec 2000 19:40:56 +0100
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E143Swc-0000DH-00@the-village.bc.nu> <00120609041800.00919@spc.esa.lanl.gov>
In-Reply-To: <00120609041800.00919@spc.esa.lanl.gov>
MIME-Version: 1.0
Message-Id: <0012061944391F.00677@twincan>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Dec 2000, Steven Cole wrote:
> On Tuesday 05 December 2000 18:00, Alan Cox wrote:
> > > I did confirm that 2.4.0-test11(final) works properly with sound and KDE
> > > 2.0.
> > Ok. That sounds even more like its PCI changes
> I copied the cs46xx.c driver from 2.4.0-test11 to 2.4.0-test11-ac1,
> rebuilt, and I got a test11-ac1 kernel which works with KDE 2.0 and sound.
[...]
A much improved version of this driver will hopefully show up real soon in the
latest test12 kernels. We, i.e. Thomas Woller from Cirrus, me and some others,
did a lot of work on the driver lately. The new driver even supports mmap sound
so that most of the games work ;)
Some others reported system freezes with the old (test11) driver which are
fixed now too.
The patch has alread been sent to Linus and will hopefully show up in test12
real soon.

> Steven
Have fun!
  nils faerber

-- 
kernel concepts          Tel: +49-271-771091-12
Dreisbachstr. 24         Fax: +49-271-771091-19
D-57250 Netphen          D1 : +49-170-2729106
--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
