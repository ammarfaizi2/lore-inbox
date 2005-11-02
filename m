Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751474AbVKBDzR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474AbVKBDzR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 22:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbVKBDzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 22:55:16 -0500
Received: from c-24-14-93-109.hsd1.il.comcast.net ([24.14.93.109]:61087 "EHLO
	topaz") by vger.kernel.org with ESMTP id S1751474AbVKBDzP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 22:55:15 -0500
From: Narayan Desai <desai@mcs.anl.gov>
To: linux-kernel@vger.kernel.org
Subject: alsa 2.6.14 record problem
Date: Tue, 01 Nov 2005 21:55:11 -0600
Message-ID: <87d5ljpuu8.fsf@topaz.mcs.anl.gov>
User-Agent: Gnus/5.110004 (No Gnus v0.4) XEmacs/21.4.17 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi. I am running 2.6.14 on a shuttle sn41g2. I have a bttv card setup
with a cable connection into the cd input on the nforce audio. I
upgraded from 2.4.30 directly to 2.6.14. This included the switch from
OSS to ALSA. This setup previously worked with mythtv flawlessly. 

After the upgrade, (now using snd_intel8x0) recording from /dev/dsp
works fine, except if I have audio playing at the same
time. Recordings made while audio playing have the correct audio on
the left channel, but the right channel includes whatever was being
played during recording.

Is this a driver bug or do I have alsa mixer settings wrong? This
seems like a odd occurrence, even with mixer settings wrong.
 -nld
