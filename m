Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132709AbRC2Lfy>; Thu, 29 Mar 2001 06:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132708AbRC2Lfo>; Thu, 29 Mar 2001 06:35:44 -0500
Received: from ghost.btnet.cz ([62.80.85.74]:4 "HELO ghost.btnet.cz")
	by vger.kernel.org with SMTP id <S132709AbRC2Lfb>;
	Thu, 29 Mar 2001 06:35:31 -0500
Date: Thu, 29 Mar 2001 12:38:31 +0200
From: clock@ghost.btnet.cz
To: linux-kernel@vger.kernel.org
Subject: diskette change problems
Message-ID: <20010329123831.A156@ghost.btnet.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I put a write-protected diskette into fd0
cat /dev/zero > /dev/fd0: readonly filesystem
then removed dikette, switched the plastic nibble
reinserted diskette
cat /dev/zero > /dev/fd0 : readonly filesystem
removed the diskette
cat /dev/zero: a bunch of garbage, then kernel spasms about sectors not found and
commands not performed
reinserted the diskette
cat /dev/zero > /dev/fd0: readonly filesystem
rebooted the machine
cat /dev/zero > /dev/fd0: run OK.

morale: if you are not able to write on a write-permitted diskette, reboot the kernel

-- 
Karel Kulhavy                     http://atrey.karlin.mff.cuni.cz/~clock
