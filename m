Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291432AbSBXVqi>; Sun, 24 Feb 2002 16:46:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291429AbSBXVqa>; Sun, 24 Feb 2002 16:46:30 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25616 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291414AbSBXVqN>;
	Sun, 24 Feb 2002 16:46:13 -0500
Message-ID: <3C795F1F.AA5E6B8@mandrakesoft.com>
Date: Sun, 24 Feb 2002 16:46:07 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-rc4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Troy Benjegerdes <hozer@drgw.net>,
        Linus Torvalds <torvalds@transmeta.com>,
        Andre Hedrick <andre@linuxdiskcert.org>,
        Rik van Riel <riel@conectiva.com.br>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Flash Back -- kernel 2.1.111
In-Reply-To: <3C794DC0.7040706@evision-ventures.com> <E16f5z8-0002id-00@the-village.bc.nu> <20020224224007.A1949@ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> I have some experimental IDE based code which can detect the PCI bus
> speed by doing some IDE transfers and measuring the time it takes. It
> isn't 100% reliable, though. I haven't found any other way to detect PCI
> clock reliably, unfortunately it cannot be safely guessed from the CPU
> clock or FSB clock or anything.

Maybe your code cannot detect the "right answer" perfectly, but at least
it could be useful as a sanity check, to let you know if the timings/bus
speed are wildly off...

	Jeff



-- 
Jeff Garzik      | "UNIX enhancements aren't."
Building 1024    |           -- says /usr/games/fortune
MandrakeSoft     |
