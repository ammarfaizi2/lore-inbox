Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283731AbRK3Rwv>; Fri, 30 Nov 2001 12:52:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283733AbRK3Rwm>; Fri, 30 Nov 2001 12:52:42 -0500
Received: from [195.63.194.11] ([195.63.194.11]:64005 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S283731AbRK3Rw1>; Fri, 30 Nov 2001 12:52:27 -0500
Message-ID: <3C07C4F9.A52C07F6@evision-ventures.com>
Date: Fri, 30 Nov 2001 18:42:17 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
Reply-To: dalecki@evision.ag
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: dalecki@evision.ag, Jeff Garzik <jgarzik@mandrakesoft.com>,
        Henning Schmiedehausen <hps@intermeta.de>,
        Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: Coding style - a non-issue
In-Reply-To: <E169rqb-0004G7-00@the-village.bc.nu>
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > irritate the oftes so called "maintainer". Two expierences:
> > ftape and mcd I'm through....
> 
> I timed the mcd maintainer out and tidied it anyway. I figured since it
> wasnt being maintained nobody would scream too loudly - nobody has

Wenn sorry for the missconception I wanted to insult *you*, my expierenc
in regard to this is even older...

> > BTW.> ftape (for the pascal emulation) and DAC960
> 
> ftape is an awkward one. Really the newer ftape4 wants merging into the
> kernel but that should have happened a long time ago

It diverged too much from what's in the kernel since about already 3-4
years.
And I don't think that it's that much better in terms of implementation
style...
Fortunately all those floppy interface iomega streamers are 
physically obsolete by now. Plese notice that ftape4 is using a
different storage format, well this is due to the fact that the
ftape inside the kernel wasn't up to the corresponding standard
(QIO-80)...

> > serial.c is another one for the whole multiport support which
> > may be used by maybe 0.1% of the Linux users thrown on them all
> > and some "magic" number silliness as well...
> 
> serial.c is a good example of the "ugly" that actually matters more, as is
> floppy.c. Clean well formatted code that is stil opaque.

floppy.c is indeed one of the best compiler test cases around there.
But personally I would excuse floppy.c a bit becouse it's dealing with
a really awkward controller interface ;-).
serial.c should be hooked at the misc char device interface sooner or
later.
But somehow this never happened becouse nobody dared to care enough.
