Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264852AbUFLPbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264852AbUFLPbN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 11:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264853AbUFLPbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 11:31:13 -0400
Received: from main.gmane.org ([80.91.224.249]:46016 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264852AbUFLPbH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 11:31:07 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: touchpad (PS/2) mouse detection problem.
Date: Sat, 12 Jun 2004 17:30:48 +0200
Message-ID: <MPG.1b354014717a9e1a9896cc@news.gmane.org>
References: <40C8EA4B.7070604@enenet.com> <MPG.1b33c0a163d6f2e59896ca@news.gmane.org> <40C9CD38.2090501@enenet.com> <MPG.1b340874c275a9479896cb@news.gmane.org> <20040612121721.GA1127@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ppp-63-129.29-151.libero.it
X-Newsreader: MicroPlanet Gravity v2.60
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> On Fri, Jun 11, 2004 at 09:39:21PM +0200, Giuseppe Bilotta wrote:
> > Vadim Garber ENEnet wrote:
> > > < > PCI PS/2 keyboard and PS/2 mouse controller
> >   ^^^
> > 
> > You need this too.
> 
> Definitely not. This is a driver for a PCI PS/2 controller so far found
> only in a Mobility Electronic docking station.

Ok, I'll just go sit in a corner and shut up. :)

Anyway, FWIW, my kernel configuration in those wereabouts is as 
follows:

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1600
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=1200
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
CONFIG_INPUT_EVDEV=m
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
CONFIG_SERIO_PCIPS2=m

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y 

Hope this helps the OP ...


-- 
Giuseppe "Oblomov" Bilotta

Can't you see
It all makes perfect sense
Expressed in dollar and cents
Pounds shillings and pence
                  (Roger Waters)

