Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269099AbRG3XzN>; Mon, 30 Jul 2001 19:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269098AbRG3XzE>; Mon, 30 Jul 2001 19:55:04 -0400
Received: from archive.osdlab.org ([65.201.151.11]:707 "EHLO fire.osdlab.org")
	by vger.kernel.org with ESMTP id <S269099AbRG3Xyy>;
	Mon, 30 Jul 2001 19:54:54 -0400
Message-ID: <3B65F330.CD4BE9DB@osdlab.org>
Date: Mon, 30 Jul 2001 16:52:16 -0700
From: "Randy.Dunlap" <rddunlap@osdlab.org>
Organization: OSDL
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-ac5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Khalid Aziz <khalid@fc.hp.com>
CC: Andreas Dilger <adilger@turbolinux.com>,
        Linux kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Support for serial console on legacy free machines
In-Reply-To: <200107302240.f6UMeWg2001230@webber.adilger.int> <3B65E711.A3828E15@fc.hp.com> <3B65EB21.C1DD8624@osdlab.org> <3B65F02B.53A8880D@fc.hp.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Khalid Aziz wrote:
> 
> "Randy.Dunlap" wrote:
> >
> > Khalid Aziz wrote:
> > > I am puzzled. How would you get "serial console" support even with ACPI
> > > unless there IS a serial port on the system????? All ACPI can do is tell
>     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > you where the serial port is.
> >
> > Wait a minute.  Aren't you the person who originally proposed this,
> > and you don't know how it's used?
> >
> > Here are 2 possibilities:
> >
> > a.  Some pre-production motherboards are built with serial ports on
> > them, only for debugging.  Never shipped to customers like this.
> > The documented I/O resources for this serial port are in the
> > special ACPI table that you referred to last Thursday.
> >
> 
> And that means system DOES have a serial port. All SPCR table does is
> tell you where it is (in I/O, memory or PCI space). SPCR table does not
> add a serial port. Some kind of serial port has to exist for SPCR table
> to be meaningful. My understanding of Andreas' question was how to get
> serial console support (or same kind of functionality) when the new
> systems do not have a serial port.

OK, thanks for the clarification.  I misunderstood Andreas's question.

> If a USB chipset could "emulate" a serial port by doing proper
> translation from read/write into USB protocol transfers, system still
> has a serial port from OS point of view and all ACPI tables will do is
> tell me where to find it.

I agree (mostly).

-- 
~Randy
