Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283718AbRLXXSv>; Mon, 24 Dec 2001 18:18:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283719AbRLXXSb>; Mon, 24 Dec 2001 18:18:31 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:21254 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S283718AbRLXXSX>; Mon, 24 Dec 2001 18:18:23 -0500
Subject: Re: IDE CDROM locks the system hard on media error
To: andre@linux-ide.org (Andre Hedrick)
Date: Mon, 24 Dec 2001 23:28:05 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), stano@meduna.org (Stanislav Meduna),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10112241231000.14431-100000@master.linux-ide.org> from "Andre Hedrick" at Dec 24, 2001 12:58:26 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16IeVp-0005XP-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If it is DMAing and there is a 1us transaction delay it is toast.
> Intel PIIX4 AB/EB is a NO-NO for doing ATAPI on.

So we should set ATAPI devices on the PIIX4 to non DMA modes ?
