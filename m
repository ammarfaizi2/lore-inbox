Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262873AbRFCL2C>; Sun, 3 Jun 2001 07:28:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262885AbRFCL1w>; Sun, 3 Jun 2001 07:27:52 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:18451 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262873AbRFCL1p>; Sun, 3 Jun 2001 07:27:45 -0400
Subject: Re: Linux 2.4.5-ac7
To: green@linuxhacker.ru (Oleg Drokin)
Date: Sun, 3 Jun 2001 12:19:52 +0100 (BST)
Cc: laughing@shared-source.org (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <200106030746.f537kSZ12820@linuxhacker.ru> from "Oleg Drokin" at Jun 03, 2001 11:46:28 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E156VvF-0004D1-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> AC> 2.4.5-ac7
> AC> o       Make USB require PCI                            (me)
> Huh?!
> How about people from StrongArm sa11x0 port, who have USB host controller (in
> sa1111 companion chip) but do not have PCI?

The strongarm doesnt have a USB master but a slave.

> Probably there are more such embedded architectures with USB controllers,
> but not PCI bus.

Currently we don't support any of them.

> How about ISA USB host controllers?

They do not exist. 
