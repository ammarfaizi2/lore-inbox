Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288174AbSBDUjn>; Mon, 4 Feb 2002 15:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288787AbSBDUjf>; Mon, 4 Feb 2002 15:39:35 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:36870 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288174AbSBDUj0>; Mon, 4 Feb 2002 15:39:26 -0500
Subject: Re: [RFC] x86 ELF bootable kernels/Linux booting Linux/LinuxBIOS
To: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 4 Feb 2002 20:51:53 +0000 (GMT)
Cc: hpa@zytor.com (H. Peter Anvin), hendriks@lanl.gov (Erik A. Hendriks),
        akpm@zip.com.au (Andrew Morton), linux-kernel@vger.kernel.org,
        wa@almesberger.net (Werner Almesberger)
In-Reply-To: <m1ofj56myg.fsf@frodo.biederman.org> from "Eric W. Biederman" at Feb 04, 2002 12:55:51 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Xq5h-0008Eu-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > A floppy disk is 1.44 MB.
> 
> Yes floppies are small.  The nice thing is that there are only 2 or 3
> floppy drivers in the kernel so it is not hard to include access to
> the primary boot medium.  

Big problems are:

-	Floppies are fast becoming optional
-	USB floppies requires the entire USB and hotplug layer
-	USB floppies require the scsi layer which is not small either
-	Libretto style non USB/Cardbus PCMCIA floppies are not supported
