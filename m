Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263751AbRFDUJr>; Mon, 4 Jun 2001 16:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263797AbRFDUJ1>; Mon, 4 Jun 2001 16:09:27 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:42764 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263751AbRFDUJT>; Mon, 4 Jun 2001 16:09:19 -0400
Subject: Re: 2.4.5-ac7 usb-uhci appears twice in /proc/interrupts
To: proski@gnu.org (Pavel Roskin)
Date: Mon, 4 Jun 2001 21:07:33 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0106040258200.2088-100000@portland.hansa.lan> from "Pavel Roskin" at Jun 04, 2001 03:07:56 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1570dR-0005tq-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't know, maybe it's Ok, but it looks confusing - usb-uhci is listed
> twice on the same IRQ 9.

It looks ok to me . You have two USB controllers sharing an IRQ

> 00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10)
> 00:07.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10)

Alan
