Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLFQfV>; Wed, 6 Dec 2000 11:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129406AbQLFQfL>; Wed, 6 Dec 2000 11:35:11 -0500
Received: from tstac.esa.lanl.gov ([128.165.46.3]:62990 "EHLO
	tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S129183AbQLFQe6>; Wed, 6 Dec 2000 11:34:58 -0500
From: Steven Cole <scole@lanl.gov>
Reply-To: scole@lanl.gov
Date: Wed, 6 Dec 2000 09:04:18 -0700
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="us-ascii"
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <E143Swc-0000DH-00@the-village.bc.nu>
In-Reply-To: <E143Swc-0000DH-00@the-village.bc.nu>
Subject: Re: 2.4.0-test12-pre4 + cs46xx + KDE 2.0 = frozen system
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <00120609041800.00919@spc.esa.lanl.gov>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 December 2000 18:00, Alan Cox wrote:
> > I did confirm that 2.4.0-test11(final) works properly with sound and KDE
> > 2.0.
>
> Ok. That sounds even more like its PCI changes
>

Some new information:

I copied the cs46xx.c driver from 2.4.0-test11 to 2.4.0-test11-ac1,
rebuilt, and I got a test11-ac1 kernel which works with KDE 2.0 and sound.

I then repeated the same with 2.4.0-test12-pre6 (which failed earlier), and
it now works too, that is I can run 2.4.0-test12-pre6 with sound and
KDE 2.0, with the old test11(final) cs46xx sound driver compiled as a module.
I didn't try compiling the old driver into the kernel, but that should work 
too. I saved the test12-pre6 cs46xx.c in case further testing is needed.

Now I'll revert to 2.4.0-test11(final) as the ReiserFS folks are warning that 
test12-pre5 is unsafe with reiserfs; a fix is in progress.

Steven
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
