Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280766AbRKBSYg>; Fri, 2 Nov 2001 13:24:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280767AbRKBSY1>; Fri, 2 Nov 2001 13:24:27 -0500
Received: from [208.232.58.25] ([208.232.58.25]:22219 "EHLO kronos.usol.com")
	by vger.kernel.org with ESMTP id <S280766AbRKBSYT>;
	Fri, 2 Nov 2001 13:24:19 -0500
Subject: APM/ACPI
From: Sean Middleditch <smiddle@twp.ypsilanti.mi.us>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.99+cvs.2001.10.30.16.08 (Preview Release)
Date: 02 Nov 2001 13:23:44 -0500
Message-Id: <1004725424.4883.33.camel@smiddle>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

On my nice new shiny cheap Compaq Laptop, I am unable to get APM
working.  It is a Via VT82C686 motherboard.  The APM support seems to be
running (RH 7.2, rawhide 2.4.12 kernels, at the moment), but I'm always
told that I'm on AC, and there is no system battery.  I do have a
battery, and I'm often not on AC power.  /proc/apm spits out the
following:

1.14ac 1.2 0x03 0x01 0x44 0x80 -1% -1 ?

This is with the AC plug pulled out.  I have no clue what the real
battery status would be.

I read there is now also ACPI, and in /proc/pci I see something about:

VT82C686 [Apollo Super ACPI]

But I don't know how to configure it.  APM seems to be compiled into the
RH kernels (there is no apm module loaded, like I would on Debian), and
I don't see anything regarding ACPI.  I also read that ACPI should
automatically take over APM if support is available.  How can I tell if
I'm not using ACPI because it's not supported, or because it's not
compiled in?

Thanks everyone!
Sean Etc.



