Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261462AbSKBW2Q>; Sat, 2 Nov 2002 17:28:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261463AbSKBW2Q>; Sat, 2 Nov 2002 17:28:16 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:12045 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261462AbSKBW2P>; Sat, 2 Nov 2002 17:28:15 -0500
Date: Sat, 2 Nov 2002 22:34:43 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Patrick Finnegan <pat@purdueriots.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kconfig (qt) -> Gconfig (gtk)
Message-ID: <20021102223443.D8549@flint.arm.linux.org.uk>
Mail-Followup-To: Roman Zippel <zippel@linux-m68k.org>,
	Patrick Finnegan <pat@purdueriots.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1036274342.16803.27.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.44.0211021652470.16432-100000@ibm-ps850.purdueriots.com> <20021102220658.C8549@flint.arm.linux.org.uk> <Pine.LNX.4.44.0211022326090.13258-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0211022326090.13258-100000@serv>; from zippel@linux-m68k.org on Sat, Nov 02, 2002 at 11:33:31PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 02, 2002 at 11:33:31PM +0100, Roman Zippel wrote:
> On Sat, 2 Nov 2002, Russell King wrote:
> 
> > Oh, and another thing I've noticed is that mconf does nothing if it
> > fails to execute lxdialog - it doesn't tell you _why_ it's doing
> > nothing.  It just says something like "Not saving configuration."
> 
> I know and I will extend the error handling there.
> 
> > | +You should rebuild lxdialog.  This can be done by moving to the
> > | +/usr/src/linux/scripts/lxdialog directory and issuing the "make clean all"
> > | +command.
> 
> $ cd /usr/src/linux/scripts/lxdialog
> -bash: cd: /usr/src/linux/scripts/lxdialog: No such file or directory
> $ cd scripts/lxdialog
> $ make clean
> Makefile:27: /Rules.make: No such file or directory
> make: *** No rule to make target `/Rules.make'.  Stop.

Well obviously it doesn't work now that kconfig removed Menuconfig!

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

