Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261274AbRFNHaX>; Thu, 14 Jun 2001 03:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261296AbRFNHaN>; Thu, 14 Jun 2001 03:30:13 -0400
Received: from hssx-sktn-167-47.sasknet.sk.ca ([142.165.167.47]:2063 "HELO
	mail.thock.com") by vger.kernel.org with SMTP id <S261274AbRFNH34>;
	Thu, 14 Jun 2001 03:29:56 -0400
Message-ID: <3B286800.565E8E@bigfoot.com>
Date: Thu, 14 Jun 2001 01:30:08 -0600
From: Dylan Griffiths <Dylan_G@bigfoot.com>
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.2.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Buggy emu10k1 drivers.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi.  The emu10k1 drivers shipped with 2.2.19 do not work well past 1Ghz. 
In the original system, an Athlon 550, all OSS sound applications worked. 
Loki games, libsdl games, XMMS, mplayer, RealPlayer, and the 'play' command
from the sox pacnage.  When I upgraded my machine to a 1Ghz TBird,
everything except XMMS would hang while the first audio buffer looped
infinitely.  It also fails at 1.1Ghz.  As a control, I enabled the onboard
audio (a C-Media Electronics Inc CM8738 (rev 10)), and was able to use all
the applications listed again (except SDL/Loki games).
	I'd fix it if I knew how since I don't like hearing bus traffic (plus the
CMeda can't play multiple sources) :-/

Please CC me since I am not on the list.
--
    www.kuro5hin.org -- technology and culture, from the trenches.
