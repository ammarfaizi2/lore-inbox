Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291862AbSBTOLz>; Wed, 20 Feb 2002 09:11:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291859AbSBTOLp>; Wed, 20 Feb 2002 09:11:45 -0500
Received: from smtp3.cern.ch ([137.138.131.164]:26244 "EHLO smtp3.cern.ch")
	by vger.kernel.org with ESMTP id <S291862AbSBTOLe>;
	Wed, 20 Feb 2002 09:11:34 -0500
To: "Torrey Hoffman" <Torrey.Hoffman@myrio.com>
Cc: "Stevie O" <stevie@qrpff.net>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.20: pci-scan+natsemi & Device or resource busy
In-Reply-To: <D52B19A7284D32459CF20D579C4B0C0211CB45@mail0.myrio.com>
From: Jes Sorensen <jes@sunsite.dk>
Date: 20 Feb 2002 15:10:23 +0100
In-Reply-To: "Torrey Hoffman"'s message of "Mon, 28 Jan 2002 10:22:22 -0800"
Message-ID: <d3vgcs6y7k.fsf@lxplus050.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Torrey Hoffman" <Torrey.Hoffman@myrio.com> writes:

> You have probably learned this by now, but I haven't seen anyone
> say it on the list, so I'll summarize...
> 
> The 2.2.x kernels did not come with drivers for the natsemi.  The 
> Donald Becker / Scyld add-on drivers were much better than nothing, 
> and we were grateful to have them, but they don't work reliably for 
> our hardware.  We are using motherboards with a soldered-on natsemi
> chip, not the Netgear FA-311.  We did hack up a version of the 
> driver that worked for us under 2.2.19, and you can get it from 
> www.myrio.com/opensource if you are interested.
> 
> However, the 2.4.x kernels come with much improved natsemi drivers. 
> These are Donald Becker's drivers, still copyright by him, but have 
> been updated a lot for 2.4 with new PCI code and lots of bugfixes.

I ran into the same problem with the natsemi driver in 2.2.x (and
rtl8139 as well). I gave up trying to fix the 2.2 drivers and instead
ended up backporting the 2.4.x drivers to 2.2.x which seems to behave
much better.

You can find the backported drivers at
http://www.wildopensource.com/proj/download/SG_drivers.html if you
find they may be useful to you.

Cheers,
Jes
