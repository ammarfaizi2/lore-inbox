Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266278AbSLCL7z>; Tue, 3 Dec 2002 06:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266285AbSLCL7z>; Tue, 3 Dec 2002 06:59:55 -0500
Received: from [81.2.122.30] ([81.2.122.30]:10501 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S266278AbSLCL7z>;
	Tue, 3 Dec 2002 06:59:55 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200212031218.gB3CIQwq005011@darkstar.example.net>
Subject: Re: Input core support required for non-USB joystick
To: bhards@bigpond.net.au (Brad Hards)
Date: Tue, 3 Dec 2002 12:18:26 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200212032233.07229.bhards@bigpond.net.au> from "Brad Hards" at Dec 03, 2002 10:33:07 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Using 2.4.20, (and possibly earlier versions, I haven't checked), it's
> > necessary to enable input core support, before non-USB joystick
> > support can be enabled.
> >
> > I thought that input core support related to USB specifically, is that
> > incorrect?

> It is incorrect. 
> When the input core support first went in, the old methods for handling 
> joysticks went out.

Ah, OK - in that case I think we should update the configuration help,
it implies that it's for USB devices only:

CONFIG_INPUT:

Say Y here if you want to enable any of the following options for
USB Human Interface Device (HID) support.

Say Y here if you want to enable any of the USB HID options in the
USB support section which require Input core support.

Otherwise, say N.

Especially as standard keyboards and mice don't require it.

> Where do you think the low major number came from? :-)

Good point :-).

John.
