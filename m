Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274714AbRIUAEZ>; Thu, 20 Sep 2001 20:04:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274716AbRIUAEQ>; Thu, 20 Sep 2001 20:04:16 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:54287 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S274714AbRIUAEG>; Thu, 20 Sep 2001 20:04:06 -0400
Subject: Re: Problem: PnP BIOS driver reports outdated information
To: jdthoodREMOVETHIS@yahoo.co.uk (Thomas Hood)
Date: Fri, 21 Sep 2001 01:09:05 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3BAA7AFC.49CEFB5D@yahoo.co.uk> from "Thomas Hood" at Sep 20, 2001 07:25:48 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15kDsP-0006er-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> think speed is a big issue here.  Are there other reasons
> for maintaining a device list in the driver?

If you query the current device status on a Vaio and some other boxes
using the 32bit API your computer dies horribly shortly afterwards.

So yes - we should be handling setpnp in the kernel, but no we can't query
the bios for the data

Alan
