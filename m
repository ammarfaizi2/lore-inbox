Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266368AbTBCOOv>; Mon, 3 Feb 2003 09:14:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266379AbTBCOOu>; Mon, 3 Feb 2003 09:14:50 -0500
Received: from [81.2.122.30] ([81.2.122.30]:45829 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S266368AbTBCOOt>;
	Mon, 3 Feb 2003 09:14:49 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200302031425.h13EP0RX015976@darkstar.example.net>
Subject: Re: Compactflash cards dying?
To: mkp@mkp.net (Martin K. Petersen)
Date: Mon, 3 Feb 2003 14:25:00 +0000 (GMT)
Cc: bryan@bogonomicon.net, pavel@ucw.cz, linux-kernel@vger.kernel.org
In-Reply-To: <yq1isw1qwwe.fsf@austin.mkp.net> from "Martin K. Petersen" at Feb 03, 2003 09:08:49 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[snip discussion about Compact Flash cards]

On a somewhat-related subject, is there currently an easy way to use a
PROM as a read-only filesystem?

I.E. I'd like to write a raw filesystem image to an PROM using a PROM
burner then connect that, probably to the parallel port, and use it as
a block device.

It should be fairly simple to build the parallel port -> PROM adaptor,
as it would essentially just be a ZIF socket, and a whole load of
latches to multiplex the limited number of I/O lines to the 32 or so
needed for address and data, and the driver should be straightforward
to write as well.

Or is there a reason why this hasn't been done?  PROMs are much
cheaper than Compact Flash...

John.
