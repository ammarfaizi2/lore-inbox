Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290338AbSAXVpB>; Thu, 24 Jan 2002 16:45:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290340AbSAXVov>; Thu, 24 Jan 2002 16:44:51 -0500
Received: from dns.uni-trier.de ([136.199.8.101]:1451 "EHLO
	rzmail.uni-trier.de") by vger.kernel.org with ESMTP
	id <S290338AbSAXVoe>; Thu, 24 Jan 2002 16:44:34 -0500
Date: Thu, 24 Jan 2002 22:44:27 +0100 (CET)
From: Daniel Nofftz <nofftz@castor.uni-trier.de>
X-X-Sender: nofftz@infcip10.uni-trier.de
To: Disconnect <lkml@sigkill.net>
cc: Daniel Nofftz <nofftz@castor.uni-trier.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [right one][patch] amd athlon cooling on kt266/266a chipset
In-Reply-To: <1011899975.2029.9.camel@oscar>
Message-ID: <Pine.LNX.4.40.0201242240380.9957-100000@infcip10.uni-trier.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 Jan 2002, Disconnect wrote:

> I just finished testing the patch, and it shows huge temperature savings
> (10 to 15C when idle).  The problem is, it screws up v4l (bttv), usb
> keyboard under X becomes effectively unusable, etc.
>
> V4l - using xinerama, xvideo, v4l under X4.1.0.1 - the picture gets
> jagged lines through it (offset scanlines maybe?) and tends to be jumpy.
>
> usb keyboard - its slightly bad under X anyway (sticky keys, modifiers,
> etc) but with this patch I had to log in from another system just to
> shut down - even ctrl-alt-delete wouldn't work. In about 15 mins of
> arguing with it I probably got 20 keystrokes into the xserver. (mouse
> continued to work fine however.)

phhhwwww ... sound problems, video problems, harddisk-dma problems ... now
usb problems ... it looks like i am a realy lucky boy that this patch
works on my computer whithout any problem ...
but : cause i have no problems with the patch, i have another problem : i
could not look where the problems come from ... :( ... so i need those on
of you, who have problems with it, so we could track the cause of the
problems down ...

>
> Seems like a great idea, if these problems can be solved. I'd love to
> get my cpu back down to 30C on a regular basis ;)
>
> (Currently running the same kernel w/o amd_disconnect=yes and it isn't
> showing any problems at all.)
>
> Motherboard is an Iwill kk266 (kt133) w/ a 1.2G tbird, 512M ram, 2
> aic7xxx (one pcb w/ pci bridge)
> Primary video: nvidia geforce2 mx (yah yah but it works ;) ..)
> Second/Third video: matrox mga g100 (4port card, 2 ports in use)
>
> Also, I noticed an odd problem w/ ACPI. dmesg shows:
> ACPI: Power Button (FF) found
> ACPI: Multiple power buttons detected, ignoring fixed-feature
> ACPI: Power Button (CM) found

as far as i know the power button does not work at all with the curent
kernel ... so i think it is no problem :)

daniel


# Daniel Nofftz
# Sysadmin CIP-Pool Informatik
# University of Trier(Germany), Room V 103
# Mail: daniel@nofftz.de

