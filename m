Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280893AbRKCAOn>; Fri, 2 Nov 2001 19:14:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280894AbRKCAOd>; Fri, 2 Nov 2001 19:14:33 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:58122 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S280893AbRKCAO0>; Fri, 2 Nov 2001 19:14:26 -0500
Subject: Re: 2.4.12-ac3 floppy module requires 0x3f0-0x3f1 ioports
To: maze@druid.if.uj.edu.pl (Maciej Zenczykowski)
Date: Sat, 3 Nov 2001 00:21:22 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0111030050520.19178-100000@druid.if.uj.edu.pl> from "Maciej Zenczykowski" at Nov 03, 2001 01:00:28 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15zoYs-00045t-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is there any reason why the floppy module requires the ioport range
> 0x3f0-0x3f1 in order to load?  On my computer /proc/ioports reports this
> range as used by PnPBIOS PNP0c02, thus the floppy module cannot reserve
> the range 0x3f0-0x3f5 and refuses to load.

This is a bug in the PnPBIOS experimental code - turn off PnPBIOS and/or
update for the moment
