Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268072AbTCDFPf>; Tue, 4 Mar 2003 00:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268153AbTCDFPf>; Tue, 4 Mar 2003 00:15:35 -0500
Received: from franka.aracnet.com ([216.99.193.44]:23753 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S268072AbTCDFPe>; Tue, 4 Mar 2003 00:15:34 -0500
Date: Mon, 03 Mar 2003 21:25:59 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: xmms (audio) skipping in 2.5 (not 2.4)
Message-ID: <103200000.1046755559@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, so I finally took the plunge, and put 2.5 on my main desktop as well as
just the lab machines ;-)

Generally seems to work very well, and VM performance is much more stable
than 2.4 ... but xmms seems to skip if I just waggle the scrollbar in some
windows. This happens most in my email client (which is Mulberry), but
other things show it to a more limited extent.

The audio pauses happen on a simple window scroll down, without intensive
CPU background activity ... they're very short in duration, which makes it
*feel* more like the audio buffer is too small than a scheduler problem,
but I'm just guessing really.

So ... is there any easy way I can diagnose this? Does anyone else have a
similar problem?

Audio is SiS SI7012 ALSA driver emulating OSS. Athalon 2100, 512Mb.
kernel = 2.5.63-mjb2

M.

PS. In the unlikely even that anyone's particularly fascinated by one app,
Mulberry isn't free, but a free demo can be downloaded from
http://www.cyrusoft.com if you wade through the registration ... as I say,
unlikely ;-)
