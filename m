Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310972AbSCRO0n>; Mon, 18 Mar 2002 09:26:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310979AbSCRO0e>; Mon, 18 Mar 2002 09:26:34 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:37133 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310972AbSCRO0S>; Mon, 18 Mar 2002 09:26:18 -0500
Subject: Re: 2.4.18 freezes on heavy IO
To: r.ems@gmx.net
Date: Mon, 18 Mar 2002 14:42:24 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C95F6B6.D3B1E921@gmx.net> from "Richard Ems" at Mar 18, 2002 03:16:22 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16myLA-0005Eb-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Now I got "hda:lost interrupt", ext3 partitions where all mounted with
> the "debug" option and the console log level was set to 8 with
> ALT-SysRq-8.
> Both Caps-Lock and Scroll-Lock LEDs where flashing, what does this mean?

Thats the code we added to detect a panic() when you are in a graphical mode
