Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267627AbTALXEs>; Sun, 12 Jan 2003 18:04:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267628AbTALXEs>; Sun, 12 Jan 2003 18:04:48 -0500
Received: from [81.2.122.30] ([81.2.122.30]:2054 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S267627AbTALXEq>;
	Sun, 12 Jan 2003 18:04:46 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200301122311.h0CNBkE1001677@darkstar.example.net>
Subject: Coding style - (Was Re: any chance of 2.6.0-test*?)
To: robw@optonline.net
Date: Sun, 12 Jan 2003 23:11:46 +0000 (GMT)
Cc: torvalds@transmeta.com, hch@infradead.org, greg@kroah.com,
       alan@lxorguk.ukuu.org.uk, wli@holomorphy.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <1042404503.1208.95.camel@RobsPC.RobertWilkens.com> from "Rob Wilkens" at Jan 12, 2003 03:48:24 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Most of a discussion about coding style removed]

> As someone else pointed out, it's provable that goto isn't needed, and
> given that C is a minimalist language, I'm not sure why it was included.

It's worth keeping in mind, when coding in *any* language, that
concepts such as loops, functions, and any kind of 'structured'
programming, are all completely artificial concepts.

Microprocessors are essentially based around:

Loading discrete values to registers.
Loading discrete values into memory locations.
Copying a value from a register or a memory location, to another
register or a memory location.
Pushing and poping values on to and off of the stack.
Jumping to another location based on whether a register contains zero
or a non zero value.

The only thing that can really be considered anything like structured
programming is the stack, (and possibly interupts).

> But at least the code is "readable" when you do that.

Assember for a simple microprocessor such as a Z80 is arguable easier
to understand than C source code for something like the Linux kernel.

It's not the language, or how it is indented, that determines how
difficult code is to read.  It's the logic in the code.

John.
