Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265995AbTAKJD7>; Sat, 11 Jan 2003 04:03:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266295AbTAKJD7>; Sat, 11 Jan 2003 04:03:59 -0500
Received: from tool9.argh.org ([193.41.144.5]:20203 "EHLO toolnine.argh.org")
	by vger.kernel.org with ESMTP id <S265995AbTAKJD6>;
	Sat, 11 Jan 2003 04:03:58 -0500
Date: Sat, 11 Jan 2003 11:12:42 +0100
From: Alexander Koch <efraim@clues.de>
To: linux-kernel@vger.kernel.org
Subject: getting my serial ports back? ;-)
Message-ID: <20030111101241.GA3589@clues.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What do I have to do to get my serial ports back?

devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
pnp: the driver 'serial' has been registered
pnp: pnp: match found with the PnP device '00:0f' and the driver 'serial'
pnp: the device '00:0f' has been activated
devfs_register(tts/2): could not append to parent, err: -17
tts/2 at I/O 0x3e8 (irq = 4) is a 16550A
pnp: pnp: match found with the PnP device '00:10' and the driver 'serial'
pnp: the device '00:10' has been activated
devfs_register(tts/3): could not append to parent, err: -17
tts/3 at I/O 0x2e8 (irq = 3) is a 16550A

Effectively as my mouse is on the serial port and it
obviously does not work in gpm or with X directly.

ttyS0: LSR safety check engaged!
ttyS0: LSR safety check engaged!
ttyS0: LSR safety check engaged!
ttyS1: LSR safety check engaged!
ttyS1: LSR safety check engaged!
ttyS1: LSR safety check engaged!

That's coming from gpm startup, at least one of it, although
I have /dev/tts/0 in my gpm.conf... Ah, it's hardcoded in the
binary, it seems (doing a strings on it).

Anyway, does anyone have a clue as to why my serial modules
are not working any longer since 2.5.53 (and neither 2.5.55)?
I am not missing it much for X but at least gpm is a good
thing.

Thanks,
Alexander

