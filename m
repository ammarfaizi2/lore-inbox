Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273112AbRIOXFI>; Sat, 15 Sep 2001 19:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273115AbRIOXE6>; Sat, 15 Sep 2001 19:04:58 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:33796 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S273112AbRIOXEo>; Sat, 15 Sep 2001 19:04:44 -0400
Subject: Re: Random Sig'11 in XF864 with kernel > 2.2.x
To: jhingber@ix.netcom.com (Jeffrey Ingber)
Date: Sun, 16 Sep 2001 00:09:43 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1000588153.7474.3.camel@DESK-2> from "Jeffrey Ingber" at Sep 15, 2001 05:09:09 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15iOZD-0002w2-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The random Sig 11's are observed in the stock XFree86 4.x drivers with
> none of the 'extras' enabled, such as DRI on several sets of video cards
> (Matrox and ATI).  I can run both UP and SMP kernels in the 2.2 series
> and 2.4 UP kernels with unlimited uptimes.  However, switching to a 2.4
> SMP kernel will cause random Sig 11's in X, seemingly irregardless of
> video card/vendor.=20

I'm aware of the reports. Its very hard to figure out what might be
involved. Later 2.4 kernels we have fixed the odd possible candidate where
segment registers or LDT propogation on SMP might go awry but nothing that
really explains the X11 ones and whether they are PCI/AGP setup , power
management or kernel bug triggered

Alan
