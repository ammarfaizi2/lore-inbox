Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLFP0D>; Wed, 6 Dec 2000 10:26:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129755AbQLFPZx>; Wed, 6 Dec 2000 10:25:53 -0500
Received: from tstac.esa.lanl.gov ([128.165.46.3]:15110 "EHLO
	tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S129183AbQLFPZq>; Wed, 6 Dec 2000 10:25:46 -0500
From: Steven Cole <scole@lanl.gov>
Reply-To: scole@lanl.gov
Date: Wed, 6 Dec 2000 07:55:05 -0700
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="us-ascii"
Cc: linux-kernel@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, scole@lanl.gov
In-Reply-To: <E143Swc-0000DH-00@the-village.bc.nu>
In-Reply-To: <E143Swc-0000DH-00@the-village.bc.nu>
Subject: Re: 2.4.0-test12-pre4 + cs46xx + KDE 2.0 = frozen system
MIME-Version: 1.0
Message-Id: <00120607550500.00858@spc.esa.lanl.gov>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 December 2000 18:00, Alan Cox wrote:
> > I did confirm that 2.4.0-test11(final) works properly with sound and KDE
> > 2.0.
>
> Ok. That sounds even more like its PCI changes
>
> > I do think its rather odd that these test12-pre3,4,5 kernels all work
> > with GNOME and the CD player works then.  KDE 2.0 is doing something
> > different at the "Loading the panel" stage that causes this bug to
> > surface.
>
> Do you have a battery monitoring applet running in KDE and not gnome ?

No, I checked the list of applets, and no battery monitoring applet.
I configured the panel  to "Load only trusted applets internal", and depleted
the list of trusted applets, tested again with test11-ac1 and it froze in the
same place as always.

With respect to a battery monitor, in the KDE control center, the Battery 
Monitor section of Power Control notes that "Your computer doesn't have the 
Linux APM (Advanced Power Management) software drivers installed, or doesn't 
have the APM kernel drivers installed -"

Steven
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
