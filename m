Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272901AbRIGXUi>; Fri, 7 Sep 2001 19:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272902AbRIGXU3>; Fri, 7 Sep 2001 19:20:29 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:53258 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272901AbRIGXUV>; Fri, 7 Sep 2001 19:20:21 -0400
Subject: Re: Toshiba IDE DMA support
To: agd5f@yahoo.com (Alex Deucher)
Date: Sat, 8 Sep 2001 00:24:39 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), agd5f@yahoo.com (Alex Deucher),
        linux-on-portege@yahoogroups.com, linux-kernel@vger.kernel.org
In-Reply-To: <20010907231336.7321.qmail@web11304.mail.yahoo.com> from "Alex Deucher" at Sep 07, 2001 04:13:36 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15fUzH-0002ou-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> this weekend if I get a chance, however, This is not a
> PCI IDE controller (at least it doesn't show up with
> lspci).  I don't know if that makes a difference or
> not.

That might make it a bit harder, it depends on the general behaviour. If
its bus mastering and follows the standard behaviour you have to provide
the chipset setup and tuning - which is normally "load xyz registers
with abc value for each mode"

Take a look at the serverworks driver
