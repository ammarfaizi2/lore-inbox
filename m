Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287511AbRLaNLg>; Mon, 31 Dec 2001 08:11:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287509AbRLaNL0>; Mon, 31 Dec 2001 08:11:26 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:41230 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287511AbRLaNLJ>; Mon, 31 Dec 2001 08:11:09 -0500
Subject: Re: 2.4.16 with es1370 pci
To: wakko@animx.eu.org (Wakko Warner)
Date: Mon, 31 Dec 2001 13:19:58 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011231065544.A28966@animx.eu.org> from "Wakko Warner" at Dec 31, 2001 06:55:44 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16L2MA-000521-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The only thing I can see is the fact it's on IRQ 15 with the usb controller.

That shouldn't matter. When it gets into this state is the IRQ counter still
ticking up when you try and play audio (you may need to unload the USB to
check that sanely)
