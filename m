Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274000AbRI0Wcb>; Thu, 27 Sep 2001 18:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273999AbRI0WcW>; Thu, 27 Sep 2001 18:32:22 -0400
Received: from [212.37.20.41] ([212.37.20.41]:7180 "HELO zaphod.nu")
	by vger.kernel.org with SMTP id <S273996AbRI0WcK>;
	Thu, 27 Sep 2001 18:32:10 -0400
From: =?us-ascii?Q?Peter_Sandstrom?= <peter@zaphod.nu>
To: "Christian Ohm" <chr.ohm@gmx.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: sound slowdown when accessing ide cdrom
Date: Sat, 29 Sep 2001 00:30:52 +0200
Message-ID: <CIEJKOKMAIAHDBBLFGFFMEAMCHAA.peter@zaphod.nu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <20010928000707.A30994@thevoid.net>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been getting this in both win2k and linux using several different
cdrom drives on an abit kt7a-raid (via kt133a) and a soundblaster awe64
isa card. Looks like the kt133 puts ide performance over isa?
I didn't have this feature on my abit bp6 (intel 440bx).

/Peter


-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Christian Ohm
Sent: den 28 september 2001 00:07
To: linux-kernel@vger.kernel.org
Subject: sound slowdown when accessing ide cdrom



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
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


