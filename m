Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276695AbRJGVxw>; Sun, 7 Oct 2001 17:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276698AbRJGVxm>; Sun, 7 Oct 2001 17:53:42 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:28425 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276695AbRJGVxY>; Sun, 7 Oct 2001 17:53:24 -0400
Subject: Re: Linux should not set the "PnP OS" boot flag
To: jdthood@mail.com (Thomas Hood)
Date: Sun, 7 Oct 2001 22:59:16 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <1002474604.831.134.camel@thanatos> from "Thomas Hood" at Oct 07, 2001 01:10:00 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15qLx6-00070R-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I append the patch that shows the sort of thing that I think needs
> to be done.  (This patch includes the change from spin_lock to 
> spin_lock_irqsave.)  The patch would need to be accompanied by the
> addition of stuff to allow the user to define CONFIG_PNPOS.

Would it not be better to tackle the job head on ? If the pnpbios scan
as it walks the devices configured them would that do the job ?
