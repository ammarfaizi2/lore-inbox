Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277165AbRKDBDZ>; Sat, 3 Nov 2001 20:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277161AbRKDBDP>; Sat, 3 Nov 2001 20:03:15 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:6674 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S277082AbRKDBC5>; Sat, 3 Nov 2001 20:02:57 -0500
Subject: Re: [PATCH] IBM T23; quirks force enable interrupts in APM set
To: linux-kernel@alex.org.uk
Date: Sun, 4 Nov 2001 01:09:45 +0000 (GMT)
Cc: jdthood@mail.com (Thomas Hood), linux-kernel@vger.kernel.org
In-Reply-To: <552962010.1004834094@[195.224.237.69]> from "Alex Bligh - linux-kernel" at Nov 04, 2001 12:34:55 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E160BnF-0007ME-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So if you want to put a patch in, I guess it could
> at least not break things on early T-23 BIOS's
> (as that's what the dmi_scan does - as the config

Send me the dmi strings (dmidecode output) for the old and new BIOS, the
URL for the firmware and not only can I make the kernel ensure they are
called IRQ off, I can make it tell you where ot get new firmware
