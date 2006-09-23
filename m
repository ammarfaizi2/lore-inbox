Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751019AbWIWMzJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbWIWMzJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 08:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751023AbWIWMzJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 08:55:09 -0400
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:20931 "EHLO
	palpatine.hardeman.nu") by vger.kernel.org with ESMTP
	id S1751029AbWIWMzE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 08:55:04 -0400
Date: Sat, 23 Sep 2006 14:54:56 +0200
From: David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@lists.sourceforge.net
Subject: snd-usb-audio problems with 2.6.18
Message-ID: <20060923125456.GA7757@hardeman.nu>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	alsa-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Content-Transfer-Encoding: 8BIT
X-SA-Score: -2.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A recent 2.6.18 kernel upgrade on one of my machines broke usb audio.

I'm using a TerraTec Aureon 5.1 USB MKII to feed ac3 audio to a 
receiver, but after the upgrade, trying to play any audio (tried aplay, 
mplayer, xine, etc...using both oss and alsa audio) results in the 
kernel log being filled with the message:

"cannot submit datapipe for urb 5, error -28: not enough bandwidth"

Unfortunately the upgrade was from 2.6.14 (yes, it's old but the machine 
has no network connection usually) so there is quite a lot of 
differences to the snd-usb-audio driver in the meantime.

Unless someone has suggestions as to a simple fix, I guess I'll 
start testing kernels in the 2.6.14 <-> 2.6.18 range soon to try to pin 
down a certain changeset...

-- 
David Härdeman
