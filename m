Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272071AbRHVSM1>; Wed, 22 Aug 2001 14:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272072AbRHVSMR>; Wed, 22 Aug 2001 14:12:17 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:35599 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272071AbRHVSMB>; Wed, 22 Aug 2001 14:12:01 -0400
Subject: Re: [Acpi] AGP support locks X  kernel v2.4.9
To: nick@coelacanth.com (Nick Papadonis)
Date: Wed, 22 Aug 2001 19:14:22 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, acpi@phobos.fachschaften.tu-muenchen.de
In-Reply-To: <m3pu9oovc6.fsf@coelacanth.com> from "Nick Papadonis" at Aug 22, 2001 01:31:05 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15ZcWE-0001yP-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I tried compiling agp support and the i810 DRI as modules for kernel v2.4.9.
> X exits out with:
> 
> (II) I810(0): Buffer map : bfb000
> (II) I810(0): [drm] added 256 4096 byte DMA buffers
> I810 Dma Initialization Failed
> 

Thats not ACPI. Linus chose to break DRI back compatibility so you can
either update your entire X11 setup, patch your kernel up by hand, or run
the -ac tree and pick the DRM 4.0 option
