Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262379AbUJ0LSf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262379AbUJ0LSf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 07:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262380AbUJ0LSf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 07:18:35 -0400
Received: from anor.ics.muni.cz ([147.251.4.35]:35278 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id S262379AbUJ0LSd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 07:18:33 -0400
Date: Wed, 27 Oct 2004 13:18:30 +0200
From: Jan Kasprzak <kas@fi.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: SWsuspend in 2.6.9 - sound card does not work
Message-ID: <20041027111830.GD4724@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi all,

I have an Asus M6R laptop (http://www.fi.muni.cz/~kas/m6r/) with ATI IXP
integrated sound card. Under 2.6.8.1 I was able to use the sound card
after software suspend (just had to restore mixer settings using alsactl).
With 2.6.9 the sound card does not work after suspend/restore: No output no
matter how I change mixer settings, and the playback is not timed properly
(e.g. when mplayer tries to synchronize audio and video stream, the video
goes too fast using all CPU time and no output to speakers/phones.

	I will do a binary search over 2.6.9-pre patches, but I want to ask
whether this problem looks familiar to anybody.

	Thanks,

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
> Whatever the Java applications and desktop dances may lead to, Unix will <
> still be pushing the packets around for a quite a while.      --Rob Pike <
