Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271667AbRICKbf>; Mon, 3 Sep 2001 06:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271665AbRICKbQ>; Mon, 3 Sep 2001 06:31:16 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:44048 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271667AbRICKbI>; Mon, 3 Sep 2001 06:31:08 -0400
Subject: Re: ide_delay_50ms question
To: jani@astechnix.ro (Jani Monoses)
Date: Mon, 3 Sep 2001 11:34:14 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10109031045530.12103-100000@virtualro.ic.ro> from "Jani Monoses" at Sep 03, 2001 10:52:44 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15dr3W-0001Qw-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> as well, because when I insert an IDE compactflash card things stop for a
> second or so nad I use a modular driver.
> And I don't know about removable harddrives but isn't the schedule_timeout
> solution better for them as well?

Some of the current drivers call it with interrupts disabled. This is one of
the things that will have to wait until 2.5 is released to really address
