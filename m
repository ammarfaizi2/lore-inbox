Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272253AbRI0WJl>; Thu, 27 Sep 2001 18:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273975AbRI0WJc>; Thu, 27 Sep 2001 18:09:32 -0400
Received: from pop.gmx.net ([213.165.64.20]:44199 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S272253AbRI0WJO>;
	Thu, 27 Sep 2001 18:09:14 -0400
Date: Fri, 28 Sep 2001 00:07:07 +0200
From: Christian Ohm <chr.ohm@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: sound slowdown when accessing ide cdrom
Message-ID: <20010928000707.A30994@thevoid.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22i
Organization: theVoid
X-Operating-System: Linux moongate 2.4.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi.

i'm using an old ide cdrom drive and a soundblaster awe64 isa pnp sound card
(using the alsa-driver). when i'm accessing the cdrom, the sound playback
slows down. a little and irregularly when copying files, more and almost
constant (about 10%) when grabbing audio using cdparanoia. it works perfect
when using the scsi cdrom drive.

i'm using an nmc 8tax+ (via kt133) mainboard with duron700 and 512mb ram,
one isa slot with the soundblaster awe64 pnp, a dawicontrol dc2975u scsi
controller (symbios logic 53c875), a matrox g400, a sis900 ethernet
controller. the ide cdrom drive is an old 4x speed drive
(/proc/ide/ide1/hdc/model says 'MATSHITA CR-581') connected to the second
ide port (without slave). i'm using kernel 2.4.9 and the oss emulation of
alsa (debian unstable packages 0.9+0beta7-1). i also tested this with the
low latency patch (which didn't change anything).

anyone knows what happens there? it seems like there's some strange
interaction of the ide cdrom driver and a timer used by (at least) alsa.

if there's some info missing i'd be happy to provide it.

bye
christian ohm

ps: since i'm not subscribed to this list, please cc all replies to me
(chr.ohm@gmx.net). thanks.
