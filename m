Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287522AbRLaNJg>; Mon, 31 Dec 2001 08:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287509AbRLaNJ0>; Mon, 31 Dec 2001 08:09:26 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:38670 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287511AbRLaNJQ>; Mon, 31 Dec 2001 08:09:16 -0500
Subject: Re: [patch] Re: Framebuffer...Why oh Why???
To: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 31 Dec 2001 13:18:47 +0000 (GMT)
Cc: akpm@zip.com.au (Andrew Morton), jsimmons@transvirtual.com (James Simmons),
        timothy.covell@ashavan.org (Timothy Covell),
        linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org)
In-Reply-To: <Pine.GSO.4.21.0112311300580.1086-100000@vervain.sonytel.be> from "Geert Uytterhoeven" at Dec 31, 2001 01:07:10 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16L2L1-00051m-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It's a bit weird... No one thinks about implementing SCSI or Ethernet drivers
> in user space, but for graphics that's all OK. Worse, for graphics it's even
> considered normal that the user space driver plays with the hardware behind the
> kernel driver's back...

Have a look at the iscsi back end. There are good reasons to do a lot of the
graphics from user space via X11 or via DRM. Performance is one very
significant case. 

Alan
