Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280938AbRLLPw5>; Wed, 12 Dec 2001 10:52:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280960AbRLLPwr>; Wed, 12 Dec 2001 10:52:47 -0500
Received: from 208-58-239-160.s160.tnt1.atnnj.pa.dialup.rcn.com ([208.58.239.160]:260
	"EHLO trianna.2y.net") by vger.kernel.org with ESMTP
	id <S280938AbRLLPwa>; Wed, 12 Dec 2001 10:52:30 -0500
Date: Wed, 12 Dec 2001 10:47:01 -0500
From: Malcolm Mallardi <magamo@ranka.2y.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.17-pre7 breaks input core/joystick?
Message-ID: <20011212104701.A333@trianna.upcommand.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Heyla, Folks.  I just noticed that 2.4.17-pre7 seems to have
broken joystick input.  Under 2.4.16, I load the gameport module,
input, joydev, the emu10k1-gp module and finally the protocol module
for the joystick, and am able to calibrate and use the joystick
normally.
	Under 2.4.17-pre7, I go through the same process and get a
/dev/js0: device not found error when I attempt to calibrate.
/dev/js0 is symlinked to /dev/input/js0 which is node 13-0
	Could this be a symlink problem (Which would be foreboding) or
could it be as I hope, and something that just cropped up in the input
core code?
	Please CC me any replies, as I'm not subscribed to the list.
--
Malcolm D. Mallardi - Dark Freak At Large
"Captain, we are receiving two-hundred eighty-five THOUSAND hails."
AOL: Nuark  UIN: 11084092 Y!: Magamo Jabber: Nuark@jabber.com
http://ranka.2y.net/~magamo/index.htm
