Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264877AbTARQGe>; Sat, 18 Jan 2003 11:06:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264878AbTARQGe>; Sat, 18 Jan 2003 11:06:34 -0500
Received: from [81.2.122.30] ([81.2.122.30]:27654 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S264877AbTARQGd>;
	Sat, 18 Jan 2003 11:06:33 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200301181615.h0IGFhUU001597@darkstar.example.net>
Subject: Re: reading from devices in RAW mode
To: folkert@vanheusden.com (Folkert van Heusden)
Date: Sat, 18 Jan 2003 16:15:43 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <003501c2bf0b$2ae93ff0$3640a8c0@boemboem> from "Folkert van Heusden" at Jan 18, 2003 05:03:39 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > There is no floppy or hard disk equivillent to reading raw sectors
> > from CD-ROMs.
> 
> Really? Are you really sure about that?

Using a standard PC floppy controller - yes.

> Back in the old days, when I did assembly on my Atari ST, I would just
> say to the controller "gimme this and that track, in RAW" and it
> would do so.

Sure, you can do it on the Amiga as well, but not on a standard PC
floppy controller.

> I thought that I could do that at least for floppy, not sure about
> harddisk (RLL through ACSI interface).

Well, you can probably do it with ST-506 interface hard disk, because
the data that goes in to that is more or less directly fed from the
head-amp, which is partly why it was so sensitive to cable length.
The closest you could probably get with any modern device would be
"read sector foo, and return data even if ECC appears to have
failed".

John.
