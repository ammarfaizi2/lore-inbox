Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274726AbRIUA7y>; Thu, 20 Sep 2001 20:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274727AbRIUA7o>; Thu, 20 Sep 2001 20:59:44 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:16144 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S274726AbRIUA70>; Thu, 20 Sep 2001 20:59:26 -0400
Subject: Re: probable hardware bug: clock timer configuration lost
To: wolfy@nobugconsulting.ro (lonely wolf)
Date: Fri, 21 Sep 2001 02:04:39 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3BAA9008.9837EA52@nobugconsulting.ro> from "lonely wolf" at Sep 21, 2001 03:55:36 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15kEkB-0006nQ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The problem: especially when copying from a disk to another one (I have
> cloned /dev/hda to /dev/hdc, testing both dd if=/dev/hda of=/dev/hdc and
> cp -a /dev/hdaN /devc/hdcN) a get _a_lot_ of messages like this one:
> 
> probable hardware bug: clock timer configuration lost - probably a
> VIA686a motherboard.
> probable hardware bug: restoring chip configuration.
> 
> Is it dangerous ? Any way to get rid of this phenomemon (maintaining the
> hardware...)?

Its harmless. When we detect this we restore the state of the chip
correctly. If anything I should kill the printk but I'd still like to 
figure the precise errata issue out 
