Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264716AbSLBR20>; Mon, 2 Dec 2002 12:28:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264733AbSLBR20>; Mon, 2 Dec 2002 12:28:26 -0500
Received: from [81.2.122.30] ([81.2.122.30]:6661 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S264716AbSLBR2Z>;
	Mon, 2 Dec 2002 12:28:25 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200212021747.gB2Hl5Mq000764@darkstar.example.net>
Subject: Re: [MAY-BE-OT] Slow FTP Transfers between 2.4 machines
To: trog@wincom.net
Date: Mon, 2 Dec 2002 17:47:05 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3deb8890.779c.0@wincom.net> from "Dennis Grant" at Dec 02, 2002 11:22:29 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This _might_ be OT... certainly I'm not entirely ready to lay this
> at the feet of the kernel just yet. Any pointers to troubleshooting
> documents would be _greatly_ appreciated.

linux-net _might_ be more appropriate.

> Boxes are connected with 10BaseT and a NetGear 10Mbs 4-port hub. Hub
> is further connected to a Samsung cable modem.

> FTP from either box to a decent server via the cable modem may go as high as
> 250-ish k/sec. FTP transfers from box to box start out at ~ 100k/sec and very
> quickly (3sec) drop to a stable 42 k/sec which persists for the rest of the
> transfer, independant of which box is server or client.

Just a few thoughts:

Have you tried connecting them directly via a crossover cable?

Are they definitely connected via a hub, and not a switch?

Maybe one of the cards is jabbering, causing a lot of packet loss,
which is only noticable when transfering between local machines?

What happens when both machines make an ftp connection to a host on
the internet?

John.
