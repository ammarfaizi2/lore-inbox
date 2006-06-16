Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750971AbWFPGH3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971AbWFPGH3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 02:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750989AbWFPGH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 02:07:29 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:29838 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1750953AbWFPGH2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 02:07:28 -0400
Message-ID: <44924A9E.6060601@drzeus.cx>
Date: Fri, 16 Jun 2006 08:07:26 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: dezheng shen <dzshen@winbond.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       PI14 SJIN <SJin@winbond.com>
Subject: Re: [Winbond] flash memory reader SCSI device drivers [headers]
References: <448E875A.40805@winbond.com> 	<9a8748490606130258k60cdf429n89b1d1d017af60fe@mail.gmail.com> 	<448FC0C1.90205@winbond.com> <4491AEAC.5030606@drzeus.cx> <44920B22.4030507@winbond.com>
In-Reply-To: <44920B22.4030507@winbond.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dezheng shen wrote:
>> PS. I have a question regarding the W83L518 hardware, but haven't been
>> able to get in touch with the right people. Perhaps you have some
>> pointers?
>
>    anything about Winbond 518/528/528DA drivers, send email to
> dzshen@winbond.com which is ME.....
>

Well, this wasn't about this driver but about some other piece of
Winbond hardware for which I have written a driver (drivers/mmc/wbsd.c).

The things I need to know are:

 * How does the hardware determine which MMC commands are data
transfers? It would seem it has a (incomplete) list of opcodes internally.

 * Is it a known hardware bug that the FIFO usage bits in the FSR
register always read as zero?

Rgds
Pierre

