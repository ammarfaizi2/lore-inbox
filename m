Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129033AbRBESGD>; Mon, 5 Feb 2001 13:06:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129041AbRBESFx>; Mon, 5 Feb 2001 13:05:53 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:41234 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S129033AbRBESFf>;
	Mon, 5 Feb 2001 13:05:35 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Gregory Maxwell <greg@linuxpower.cx>
Date: Mon, 5 Feb 2001 19:04:12 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Matrox Marvell G400
CC: linux-kernel@vger.kernel.org, wakko@animx.eu.org
X-mailer: Pegasus Mail v3.40
Message-ID: <14A23BF37616@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  5 Feb 01 at 12:36, Gregory Maxwell wrote:
> On Mon, Feb 05, 2001 at 11:31:57AM -0500, Wakko Warner wrote:
> > How well is this card supported for it's capture capabilities and dual head?
> 
> Capture and dual head are almost totally unsupported without using a
> proprietary, binary only driver chunk which will soundly place your system as
> 'unsupported' as far as this list is concerned due to the difficulty of
> debugging a system when sourceless software bangs the hardware.

Under X. Under framebuffer both heads of G400 will work for you if
it is your primary video devices. For capture capabilities see
http://marvel.sourceforge.net. It for sure worked sometime in the past,
but I'm not sure about current state. But I believe that at least
watching TV works correctly.

And if you insist on X, you can run first head through mga with 
usefbdev /dev/fb0 with hwcursor off, and secondary head through fbdev
/dev/fb1. But it is not supported by me (and neither by XFree guys AFAIK,
not even talking about Matrox support guys) - I support only first head
in X and secondary head used for 'fbtv -k'.

> If this situation is not ideals for you, I suggest you address the issue
> with Matrox. 

I'm trying... more or less. Next G450 BIOSes will have fix for
matroxfb deadlock on boot, so there is at least some move. Although now
when workaround is implemented in matroxfb, it is a bit late...
                                        Best regards,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz

BTW, under G450 output to TV is not supported and I'm not sure it ever
will. Output to second monitor is of course supported.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
