Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129183AbQKYNJ6>; Sat, 25 Nov 2000 08:09:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129228AbQKYNJt>; Sat, 25 Nov 2000 08:09:49 -0500
Received: from cmailg5.svr.pol.co.uk ([195.92.195.175]:11056 "EHLO
        cmailg5.svr.pol.co.uk") by vger.kernel.org with ESMTP
        id <S129183AbQKYNJf>; Sat, 25 Nov 2000 08:09:35 -0500
Date: Sat, 25 Nov 2000 12:39:32 +0000
From: Paul Warren <pdw@ex-parrot.com>
To: linux-kernel@vger.kernel.org
Subject: Problem with NM256 and APM
Message-ID: <20001125123932.H1467@cerberus.grovehouse.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a problem with APM interfering with sound playback through a
NeoMagic 256.  

If I have sound playing, and do a "cat /proc/apm" I get a noticeable
glitch in sound playback.  The glitch sounds like playback skips
backwards by a fraction of a second.

The machine is a Dell Latitude CS, and I have seen this problem on
2.2.17 and 2.4.0test11.

The anonymous author of the NM256 driver claims to have not seen this
problem before.

dmesg says:

apm: BIOS version 1.2 Flags 0x03 (Driver version 1.13)
...
NeoMagic 256AV/256ZX audio driver, version 1.1
NM256: Found card signature in video RAM: 0x3fec00
NM256: Mapping port 1 from 0x3e6c00 - 0x3fec00
Initialized NeoMagic 256ZX audio in PCI native mode
Initialized AC97 mixer
Done installing NM256 audio driver.

Any clues as to what might be behind this?

cheers,

Paul
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
