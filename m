Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290815AbSARWgI>; Fri, 18 Jan 2002 17:36:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290858AbSARWf6>; Fri, 18 Jan 2002 17:35:58 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:8715 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S290857AbSARWfx>; Fri, 18 Jan 2002 17:35:53 -0500
Subject: Re: [PATCH] IBM Lanstreamer bugfixes
To: yoder1@us.ibm.com (Kent E Yoder)
Date: Fri, 18 Jan 2002 22:47:48 +0000 (GMT)
Cc: jgarzik@mandrakesoft.com (Jeff Garzik), linux-kernel@vger.kernel.org
In-Reply-To: <OFA503EFC2.D11026CD-ON85256B45.007B6E25@raleigh.ibm.com> from "Kent E Yoder" at Jan 18, 2002 04:32:31 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16RhnY-00087R-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   actually I should be using spin_lock_irqsave() in open() and close()
> since the lock is taken inside the interrupt function, no?

Correct - which might explain some of your other delays curing lockups
