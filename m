Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265424AbTA1N6P>; Tue, 28 Jan 2003 08:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265446AbTA1N6P>; Tue, 28 Jan 2003 08:58:15 -0500
Received: from [81.2.122.30] ([81.2.122.30]:36868 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S265424AbTA1N6P>;
	Tue, 28 Jan 2003 08:58:15 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200301281406.h0SE6U1t000751@darkstar.example.net>
Subject: Re: Bootscreen
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Tue, 28 Jan 2003 14:06:30 +0000 (GMT)
Cc: wichert@wiggy.net, linux-kernel@vger.kernel.org
In-Reply-To: <1043761632.1316.67.camel@dhcp22.swansea.linux.org.uk> from "Alan Cox" at Jan 28, 2003 01:47:13 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > It takes a while before the kernel starts init though, especially if you
> > have things like SCSI controllers to initialise. If you do not use fb
> > you can have your bootloader setup a pretty bootscreen, but if you need
> > fb I don't see how you can prevent the textscreen with kernel messages.
> 
> I'd not really pondered people who compile many drivers into their kernel
> instead of into the initrd. I guess a few people still do that.

I don't usually compile support for modules in at all, and even on
486s the boot time isn't *that' long.  30 Seconds or so on a 4 Mb RAM,
486 SX 20 for a complete boot, only about half than until init starts.

I personally don't think a few seconds of text mode is a major
problem.

What I'm wondering is how long it will be before text mode is no
longer implemented in VGA cards at all.  Once the BIOS stops using it,
who needs it anymore?

John
