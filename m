Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261696AbTJRQjT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 12:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261699AbTJRQjT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 12:39:19 -0400
Received: from fep01.swip.net ([130.244.199.129]:35576 "EHLO
	fep01-svc.swip.net") by vger.kernel.org with ESMTP id S261696AbTJRQjN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 12:39:13 -0400
From: jjluza <jjluza@free.fr>
To: linux-kernel@vger.kernel.org
Subject: 2.6-test8 : alsa hangs my box
Date: Sat, 18 Oct 2003 18:39:07 +0200
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310181839.07857.jjluza@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've just installed this new version on my nforce2 based box.
I use the alsa module named snd_intel8x0 to make my nforce2 audio unit 
working.
But when I try to access the audio devices with two program simultaneously, it 
hangs.
I tested by playing a music with xmms (using the alsa audio output), then, at 
the same time, running mplayer to play a movie (using -ao alsa9), and it 
hangs.
I get no error, but I can't kill mplayer (even with ctrl c).
I tried to get its pid with top and ps aux, but they hangs too, when they try 
to get information about mplayer. So I can't kill it since I can't get its 
pid.

Finally, I tried to reboot my computer, and it hangs when it tried to shut 
down alsa.

I use a debian sid (it is up-to-date).

