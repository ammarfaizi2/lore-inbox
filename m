Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273606AbRIQM6q>; Mon, 17 Sep 2001 08:58:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273603AbRIQM6g>; Mon, 17 Sep 2001 08:58:36 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:57868 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S273602AbRIQM62>; Mon, 17 Sep 2001 08:58:28 -0400
Subject: Re: PCI - Tseng ET6000 - bad memory amount  detection
To: mmark@koala.ichpw.zabrze.pl
Date: Mon, 17 Sep 2001 14:03:23 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org)
In-Reply-To: <200109171244.f8HCiTZ00707@koala.ichpw.zabrze.pl> from "Marek Mentel" at Sep 17, 2001 02:33:19 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15iy3X-00077o-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Looking  for lscpci  output  I have found that amount of detected
> memory on my  SVGA Tseng ET6000 is incorrect :

The PCI table reports the amount of address space allocated, not memory. It
is quite common for this to be more than the memory. Sometimes there
are gaps, sometimes the memory is accessible big endian, and little endian
at different offsets - etc

Alan
