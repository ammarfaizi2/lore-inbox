Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264715AbTBOJEy>; Sat, 15 Feb 2003 04:04:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264724AbTBOJEy>; Sat, 15 Feb 2003 04:04:54 -0500
Received: from [81.2.122.30] ([81.2.122.30]:10756 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S264715AbTBOJEx>;
	Sat, 15 Feb 2003 04:04:53 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200302150913.h1F9Du9q000369@darkstar.example.net>
Subject: Re: [PATCH][RFC] Proposal for a new watchdog interface using sysfs
To: cort@fsmlabs.com (Cort Dougan)
Date: Sat, 15 Feb 2003 09:13:56 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk, rusty@linux.co.intel.com, pavel@ucw.cz,
       linux-kernel@vger.kernel.org, mochel@osdl.org, davej@codemonkey.org.uk,
       daniel@rimspace.net
In-Reply-To: <20030215082707.GE13148@host109.fsmlabs.com> from "Cort Dougan" at Feb 15, 2003 01:27:07 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> } > The watchdog infrastructure would just show what ever integer the driver
> } > provides via the watchdog_ops.get_temperature() function pointer, so it
> } > would be up to the driver developer to decide if the data is really
> } > Fahrenheit or whatever.
> } 
> } We do need to be sure they all agree about it however 8)
> 
> Just to make sure no-one is happy except physicists, I suggest
> Kelvin.

Degrees C is the best choice, because the range of values that fit in
to a signed int is then useful (-127 -> 128).  Storing as K or F means
that you can't store a useful range in a single byte.

> I also suggest we spell disk/disc as "disck".

Magnetic media                       -> disk
Optical media                        -> disc
Combination media, (magneto-optical) -> disk

John.
