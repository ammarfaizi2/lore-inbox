Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129093AbQKDUUb>; Sat, 4 Nov 2000 15:20:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129103AbQKDUUV>; Sat, 4 Nov 2000 15:20:21 -0500
Received: from tetsuo.zabbo.net ([204.138.55.44]:18699 "HELO tetsuo.zabbo.net")
	by vger.kernel.org with SMTP id <S129093AbQKDUUN>;
	Sat, 4 Nov 2000 15:20:13 -0500
Date: Sat, 4 Nov 2000 15:20:12 -0500
From: Zach Brown <zab@zabbo.net>
To: linux-kernel@vger.kernel.org
Subject: maestro3 2.2 oss driver snapshot
Message-ID: <20001104152012.G25712@tetsuo.zabbo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://www.zabbo.net/maestro3/

contains a driver for the maestro3 and allegro chipsets that I'm fairly
happy with.

its 2.2 only for now, play with 2.4 at your own risk.  for now it
includes its own ac97_codec.c that is backported from 2.2.

I expect playback to work as well as ac97 mixing.  apm support works pretty
darn well, you can suspend during pcm playback and it should start
playing again on resume.  mmap() should work, but is untested.

record does not work at all.

if you test it, please let me know how it goes and tell me all about
your hardware.  I'll have a polished version later that will be submitted
into the kernel proper.

-- 
 zach
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
