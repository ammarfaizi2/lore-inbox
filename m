Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314475AbSD1T6U>; Sun, 28 Apr 2002 15:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314477AbSD1T6T>; Sun, 28 Apr 2002 15:58:19 -0400
Received: from mercury.chembio.ntnu.no ([129.241.80.86]:7634 "EHLO
	mercury.chembio.ntnu.no") by vger.kernel.org with ESMTP
	id <S314475AbSD1T6T>; Sun, 28 Apr 2002 15:58:19 -0400
To: rudmer@legolas.dynup.net
Cc: Dave Jones <davej@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.10-dj1
In-Reply-To: <20020427030823.GA21608@suse.de>
	<200204271313.g3RDD4024060@smtp1.wanadoo.nl>
	<20020427155116.I14743@suse.de>
	<200204281145.g3SBjJJ20178@smtp2.wanadoo.nl>
From: Alexander Hoogerhuis <alexh@ihatent.com>
Date: 28 Apr 2002 21:53:10 +0200
Message-ID: <m3lmb7zjkp.fsf@lapper.ihatent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rudmer van Dijk <rudmer@legolas.dynup.net> writes:

> On Saturday 27 April 2002 15:51, Dave Jones wrote:
> > On Sat, Apr 27, 2002 at 02:51:21PM +0200, Rudmer van Dijk wrote:
> >  > compiled fine, but after booting the system does not respond to the
> >  > keyboard (I can see the message "serio: i8042 KBD port at 0x60,0x64 irq
> >  > 1" om my screen)
> >
> > There are some reports that ACPI is having a bad interaction with the
> > keyboard controller. For now, disabling it may fix this.
> 
> I have no ACPI or APM enabled (mobo does not know what it is)
> 

I have an Compaq Armada M700, same problem. No ACPI configured,
symtoms vary a bit from kernel to kernel, but generally either
keyboard is totally dead, or it starts to get utterly confused about
caps lock and shift.

On 2.5.10-dj1 it works like this: keyboard led is responsive to
hitting caps lock, but when LED is off I get upper case letter typed,
and when LED is off I get lower case letters. However, the strange bit
is that lets say I type in my username and password so that they
appear in lowercase on the screen, I still don't get in. And just fir
having tried, typing with the caps lock LED off, thus getting upper
case text, doesn't help either.

Any pointer to where I go off to track this down?

ttfn,
A
-- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy
