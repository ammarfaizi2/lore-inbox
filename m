Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129319AbQLRTT4>; Mon, 18 Dec 2000 14:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129391AbQLRTTq>; Mon, 18 Dec 2000 14:19:46 -0500
Received: from athena.intergrafix.net ([206.245.154.69]:7686 "HELO
	athena.intergrafix.net") by vger.kernel.org with SMTP
	id <S129319AbQLRTTe>; Mon, 18 Dec 2000 14:19:34 -0500
Date: Mon, 18 Dec 2000 13:49:07 -0500 (EST)
From: Admin Mailing Lists <mlist@intergrafix.net>
To: linux-kernel@vger.kernel.org
Cc: kde-user@lists.netcentral.net
Subject: system locks HARD on KDE start
Message-ID: <Pine.LNX.4.10.10012181329080.3422-100000@athena.intergrafix.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I'm trying to get kde2 running and i'm not positive if it's a KDE problem,
or a kernel thing.
Whenever I start kde, the kde startup gets so far and the system freezes.
Sometimes it does it at "Loading the panel" sometimes it'll get to "100%
KDE is up and running" and do it. When it does it the hard drive light
stays on. I can't see if the kernel is oopsing because it's stuck in
graphics mode. Alt-SysRq to sync/unmount disks doesn't seem to work,
because i reset and all the drives go into fsck.
I've tried the following combinations:
kde 2.0 (final and pres)/qt 2.2.1/xfree 3.3.6/kernel 
2.2.15pre18|2.2.18pre20
kde 2.0.1/qt 2.2.2/xfree 4.0.1|3.3.6/kernel 2.2.15pre18|2.2.18pre20
All are compiled from source.

X runs fine with just tvm.
glibc is 2.1.3. gcc is 2.95.2
I used to run libc5, and kde 2.0 would startup fine, but i had many
SEGV/ABRTs making it unusable, which is why i upgraded to 2.1.3. libc5 is
still around just for existing apps.
Nothing fancy compiled in kernel..no I2C, USB, sound, or power management.
Running PR440FX mobo with dual ppro 200s, SCSI drives (i've also tried a
new hard drive), 384MB ram, Diamond Stealth 2000

Any help is appreciated,

-Tony
.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-.
Anthony J. Biacco                       Network Administrator/Engineer
thelittleprince@asteroid-b612.org       Intergrafix Internet Services

    "Dream as if you'll live forever, live as if you'll die today"
http://www.asteroid-b612.org                http://www.intergrafix.net
.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
