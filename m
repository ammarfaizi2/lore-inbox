Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288584AbSADKZD>; Fri, 4 Jan 2002 05:25:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288583AbSADKYx>; Fri, 4 Jan 2002 05:24:53 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:39951 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288581AbSADKYp>; Fri, 4 Jan 2002 05:24:45 -0500
Subject: Re: ASUS KT266A/VT8233 board and UDMA setting
To: vojtech@suse.cz (Vojtech Pavlik)
Date: Fri, 4 Jan 2002 10:35:32 +0000 (GMT)
Cc: pogosyan@phys.ualberta.ca (Dmitri Pogosyan), linux-kernel@vger.kernel.org
In-Reply-To: <20020104102507.A20412@suse.cz> from "Vojtech Pavlik" at Jan 04, 2002 10:25:07 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16MRhE-0003Rx-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Some RH kernels (may include yours) deliberately disable UDMA3, 4 and 5
> on any VIA IDE controller. I don't know why. Unpatch your kernel and
> it'll likely work.

RH 2.4.2-x. That was before we had the official VIA solution to the chipset
bug. It was better to be safe than sorry for an end user distro.

Alan
