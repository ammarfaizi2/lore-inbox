Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291444AbSBXVus>; Sun, 24 Feb 2002 16:50:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291448AbSBXVul>; Sun, 24 Feb 2002 16:50:41 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:64260 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S291444AbSBXVuZ>; Sun, 24 Feb 2002 16:50:25 -0500
Date: Sun, 24 Feb 2002 22:50:22 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Troy Benjegerdes <hozer@drgw.net>,
        Linus Torvalds <torvalds@transmeta.com>,
        Andre Hedrick <andre@linuxdiskcert.org>,
        Rik van Riel <riel@conectiva.com.br>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Flash Back -- kernel 2.1.111
Message-ID: <20020224225022.A2047@ucw.cz>
In-Reply-To: <3C794DC0.7040706@evision-ventures.com> <E16f5z8-0002id-00@the-village.bc.nu> <20020224224007.A1949@ucw.cz> <3C795F1F.AA5E6B8@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C795F1F.AA5E6B8@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Sun, Feb 24, 2002 at 04:46:07PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 24, 2002 at 04:46:07PM -0500, Jeff Garzik wrote:

> > I have some experimental IDE based code which can detect the PCI bus
> > speed by doing some IDE transfers and measuring the time it takes. It
> > isn't 100% reliable, though. I haven't found any other way to detect PCI
> > clock reliably, unfortunately it cannot be safely guessed from the CPU
> > clock or FSB clock or anything.
> 
> Maybe your code cannot detect the "right answer" perfectly, but at least
> it could be useful as a sanity check, to let you know if the timings/bus
> speed are wildly off...

Yes, but actually the bus speeds are never 'wildly off', the realistic
values being somewhere between 25 to 41.5 MHz, and because all the new
mainboards have the FSB tunable with a resolution of a single megahertz,
almost all values in this range are posible. And even quite small
changes make sometimes a huge difference (works or doesn't).

-- 
Vojtech Pavlik
SuSE Labs
