Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317180AbSFBNk2>; Sun, 2 Jun 2002 09:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317181AbSFBNk1>; Sun, 2 Jun 2002 09:40:27 -0400
Received: from mail.uni-kl.de ([131.246.137.52]:6605 "EHLO uni-kl.de")
	by vger.kernel.org with ESMTP id <S317180AbSFBNk1>;
	Sun, 2 Jun 2002 09:40:27 -0400
Date: Sun, 2 Jun 2002 15:40:25 +0200
From: Eduard Bloch <edi@gmx.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Too many mixer devices in devfs
Message-ID: <20020602134025.GA1296@zombie.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I noticed this behaviour in 2.4.18 and it is still reproducible with
2.4.19pre8. With devfs, the /dev/sound/ directory allways contains four
mixer devices, even when all sound drivers are unloaded. There are also
other device files that do not appear and disappear when not needed. If
this is a feature (what I doubt), then it is a very bad one. It is not
consitent with default devfs behaviour or even other versions of it.

# ls /dev/sound
audio
dspW
mixer0
mixer1
mixer2
mixer3
sequencer
sequencer2

Gruss/Regards,
Eduard.
-- 
begin  LOVE-LETTER-FOR-YOU.txt.vbs
I am a signature virus. Distribute me until the bitter
end

