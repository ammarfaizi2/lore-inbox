Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313174AbSDDOWc>; Thu, 4 Apr 2002 09:22:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313175AbSDDOWW>; Thu, 4 Apr 2002 09:22:22 -0500
Received: from pool-141-154-203-50.bos.east.verizon.net ([141.154.203.50]:5504
	"EHLO book.ducksong.com") by vger.kernel.org with ESMTP
	id <S313174AbSDDOWM>; Thu, 4 Apr 2002 09:22:12 -0500
Date: Thu, 4 Apr 2002 09:23:08 -0500
From: "Patrick R. McManus" <mcmanus@ducksong.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19-pre4-ac4 kills my gdm
Message-ID: <20020404142308.GA1177@ducksong.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is kind of odd - I have an Athlon 850 with a sis 730 chipset. X
detects the "sis 630" as my video chipset.

under 2.4.19-pre4-ac3 all is good - reboot to 2.4.19-pre4-ac4 and gdm
won't start.

X does start successfully.. but not gdm. I can go to runlevel 3 and
run startx without a problem (i.e. get a window manager, etc..)

If I boot back to 2.4.19-pre4-ac3 all is well again.

/var/log/gdm/:0.log complains of a lock

-----
Fatal server error:
Server is already active for display 0
        If this server is no longer running, remove /tmp/.X0-lock
        and start again.


When reporting a problem related to a server crash, please send
the full server output, not just the last messages.
Please report problems to xfree86@xfree86.org.
-----

However clearing the lock (and making sure its gone when the sever
starts) is of no help. 

-Patrick



