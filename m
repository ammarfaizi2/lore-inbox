Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261460AbSKBW1N>; Sat, 2 Nov 2002 17:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261462AbSKBW1N>; Sat, 2 Nov 2002 17:27:13 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:61188 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S261460AbSKBW1M>; Sat, 2 Nov 2002 17:27:12 -0500
Date: Sat, 2 Nov 2002 23:33:31 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Russell King <rmk@arm.linux.org.uk>
cc: Patrick Finnegan <pat@purdueriots.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kconfig (qt) -> Gconfig (gtk)
In-Reply-To: <20021102220658.C8549@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0211022326090.13258-100000@serv>
References: <1036274342.16803.27.camel@irongate.swansea.linux.org.uk>
 <Pine.LNX.4.44.0211021652470.16432-100000@ibm-ps850.purdueriots.com>
 <20021102220658.C8549@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 2 Nov 2002, Russell King wrote:

> Oh, and another thing I've noticed is that mconf does nothing if it
> fails to execute lxdialog - it doesn't tell you _why_ it's doing
> nothing.  It just says something like "Not saving configuration."

I know and I will extend the error handling there.

> | +You should rebuild lxdialog.  This can be done by moving to the
> | +/usr/src/linux/scripts/lxdialog directory and issuing the "make clean all"
> | +command.

$ cd /usr/src/linux/scripts/lxdialog
-bash: cd: /usr/src/linux/scripts/lxdialog: No such file or directory
$ cd scripts/lxdialog
$ make clean
Makefile:27: /Rules.make: No such file or directory
make: *** No rule to make target `/Rules.make'.  Stop.

bye, Roman

