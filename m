Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317440AbSFRPGb>; Tue, 18 Jun 2002 11:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317443AbSFRPGa>; Tue, 18 Jun 2002 11:06:30 -0400
Received: from web12305.mail.yahoo.com ([216.136.173.103]:29712 "HELO
	web12305.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S317440AbSFRPGa>; Tue, 18 Jun 2002 11:06:30 -0400
Message-ID: <20020618150628.12694.qmail@web12305.mail.yahoo.com>
Date: Tue, 18 Jun 2002 08:06:28 -0700 (PDT)
From: Myrddin Ambrosius <imipak@yahoo.com>
Subject: Drivers, Hardware, and their relationship to Bagels.
To: linux-kernel@vger.kernel.org
In-Reply-To: <1022276970.4174.153.camel@bip>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-403857871-1024412788=:10967"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-403857871-1024412788=:10967
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

With the discussion on kernel crypto a while back,
there was one very important recurring element that I
would like someone to clarify for me.

The issue is this. My understanding is that -all-
hardware access should be through the kernel, partly
so that similar hardware can have a similar API, but
also so that kernel security code (eg: capabilities)
applies to ALL hardware and ALL lower-level
operations.

However, there were a number of mentions of userland
hardware drivers, which did NOT operate through the
kernel. (This was in reference to why it wouldn't be
necessary to have a kernel-level driver for the
Motorola M190 crypto chip.)

If you can blithely ignore restrictions placed by the
kernel on some piece of hardware, and access it
directly, then surely this would apply to any
hardware. Including disk drives, RAM, etc.

I could be wrong (and I hope, very much, that I am),
but if my understanding is correct, then that's a hole
you could drive a truck through, and have room to
spare.

This isn't intended as a critisism of anyone, or of
any decisions made regarding the way the kernel
operates. (I know my phrasing leaves a lot to be
desired. Sometimes I think my best chance of a long
life would be to take a vow of silence and become a
monk.)

I'd really appreciate it if someone could clarify this
for me, especially the security aspect of non-kernel
drivers.


__________________________________________________
Do You Yahoo!?
Yahoo! - Official partner of 2002 FIFA World Cup
http://fifaworldcup.yahoo.com
--0-403857871-1024412788=:10967
Content-Type: text/plain; name="ks.txt"
Content-Description: ks.txt
Content-Disposition: inline; filename="ks.txt"

(Tune of "Running Free", by Iron Maiden)

Kernel bug, core runs wild,
Space/time twists and gets compiled.
Wormholes open and bring to me,
Linux Kernel Version 3!

I'm running 3, yeah, I'm running 3!
I'm running 3, yeah, I'm running 3!

Got support for Tbyte RAM,
The newest arch is leg of lamb.
Max cpus, one thousand now,
Neg latency gives quite a pow.

Men in Black zap my brains,
Melt the hard-disk, and what remains.
There's nothing left for you to see
That my machine was running 3!

--0-403857871-1024412788=:10967--
