Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313054AbSC0R6v>; Wed, 27 Mar 2002 12:58:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313055AbSC0R6b>; Wed, 27 Mar 2002 12:58:31 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:15634 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313054AbSC0R62>; Wed, 27 Mar 2002 12:58:28 -0500
Subject: Re: Confliction between my device and printer
To: mylinuxk@yahoo.ca (Michael Zhu)
Date: Wed, 27 Mar 2002 18:15:07 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020327155452.96224.qmail@web14901.mail.yahoo.com> from "Michael Zhu" at Mar 27, 2002 10:54:52 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16qHwx-0005ks-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> problem. Now I am just wondering in Linux how can I
> check whether the parallel port resource is avaliable.
> I need to add that kind of code to my device driver.
> Thank you very much.

Use the parport api instead of banging directly on the hardware. That
supports the needed resource handling as well as isolating non PC
parallel weirdness. drivers/paride/.. has lots of examples 
