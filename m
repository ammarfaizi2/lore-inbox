Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263452AbRFCQB5>; Sun, 3 Jun 2001 12:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263338AbRFCPGh>; Sun, 3 Jun 2001 11:06:37 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:3589 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263210AbRFCPG3>; Sun, 3 Jun 2001 11:06:29 -0400
Subject: Re: Linux 2.4.5-ac7
To: nico@cam.org (Nicolas Pitre)
Date: Sun, 3 Jun 2001 16:03:58 +0100 (BST)
Cc: green@linuxhacker.ru (Oleg Drokin), laughing@shared-source.org (Alan Cox),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0106031053110.1312-100000@xanadu.home> from "Nicolas Pitre" at Jun 03, 2001 10:56:53 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E156ZQ6-0004Pr-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If it ever gets to a stability point where it's worth including in Alan's
> tree, then the dependency could easily be modified to be "USB requires PCI
> or SA1111".  In the mean time I keep that hairball in my tree.

Even cleaner might be

USB requires nothing
usb-ohci requires PCI (which it definitely does now with the API's it uses)
usb-uchi requires PCI 
uhci requires PCI
[other controllers]

USB devices requires a USB controller was selected

