Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261483AbSKBW5p>; Sat, 2 Nov 2002 17:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261486AbSKBW5p>; Sat, 2 Nov 2002 17:57:45 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:19972 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S261483AbSKBW5o>; Sat, 2 Nov 2002 17:57:44 -0500
Date: Sun, 3 Nov 2002 00:03:59 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Sam Ravnborg <sam@ravnborg.org>
cc: Russell King <rmk@arm.linux.org.uk>,
       Patrick Finnegan <pat@purdueriots.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kconfig (qt) -> Gconfig (gtk)
In-Reply-To: <20021102224716.GA15134@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.44.0211030001240.13258-100000@serv>
References: <1036274342.16803.27.camel@irongate.swansea.linux.org.uk>
 <Pine.LNX.4.44.0211021652470.16432-100000@ibm-ps850.purdueriots.com>
 <20021102220658.C8549@flint.arm.linux.org.uk> <Pine.LNX.4.44.0211022326090.13258-100000@serv>
 <20021102224716.GA15134@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 2 Nov 2002, Sam Ravnborg wrote:

> But thats only OK within a kbuild makefile.
> Is there any real need for an external make clean for lxdialog?

Not really (anymore), if one tries to configure a kernel tree under a 
different architecture, make will already fail to execute 
scripts/kconfig/mconf.

bye, Roman

