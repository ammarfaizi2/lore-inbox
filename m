Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131887AbRBQUm4>; Sat, 17 Feb 2001 15:42:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132023AbRBQUmq>; Sat, 17 Feb 2001 15:42:46 -0500
Received: from mercury.ST.HMC.Edu ([134.173.57.219]:1284 "HELO
	mercury.st.hmc.edu") by vger.kernel.org with SMTP
	id <S131887AbRBQUmn>; Sat, 17 Feb 2001 15:42:43 -0500
From: Nate Eldredge <neldredge@hmc.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14990.57922.176851.105401@mercury.st.hmc.edu>
Date: Sat, 17 Feb 2001 12:42:42 -0800
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: neldredge@hmc.edu (Nate Eldredge), linux-kernel@vger.kernel.org
Subject: Re: 2.4.1ac17 hang on mounting loopback fs
In-Reply-To: <E14UE0r-00071Q-00@the-village.bc.nu>
In-Reply-To: <14990.18933.849551.526672@mercury.st.hmc.edu>
	<E14UE0r-00071Q-00@the-village.bc.nu>
X-Mailer: VM 6.76 under Emacs 20.5.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:
 > > # mount -t ext2 -o loop /spare/i486-linuxaout.img /spare/mnt
 > > loop: enabling 8 loop devices
 > 
 > Loop does not currently work in 2.4. It might partly work by luck
 > but thats it.  This will change as and when the new loop patches go
 > in. Until then if you need loop use 2.2

I see.  Thank you.  I can live without it until then.

Btw, I applied Jens Axboe's loop-3 patch as suggested by Ville Herva.
It applied with some fuzz and offset.  However, when I booted it, the
kernel oopsed when I tried to mount the first ordinary ext2 partition
(no loopback involved).  I can post the oops if anyone cares, but I
presume that loop-3 and 2.4.1ac17 are just incompatible.

-- 

Nate Eldredge
neldredge@hmc.edu
