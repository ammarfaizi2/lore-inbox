Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751110AbWCROGB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbWCROGB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 09:06:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751054AbWCROGB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 09:06:01 -0500
Received: from fmmailgate05.web.de ([217.72.192.243]:65456 "EHLO
	fmmailgate05.web.de") by vger.kernel.org with ESMTP
	id S1751090AbWCROGB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 09:06:01 -0500
Message-ID: <441C13C1.7000902@web.de>
Date: Sat, 18 Mar 2006 15:05:53 +0100
From: Marcus Hartig <m.f.h@web.de>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.16-rcX - no more sound with ALSA snd-hda-intel / Sigmatel
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Since the 2.6.16.rcX kernel versions I have no more sound with the ALSA 
snd-hda-intel driver. All modules load without errors, all  channels are 
unmuted, no errors in any log, but sound is death! :(

With kernel 2.6.15.6 (ALSA 1.0.10rc3) the sound is working, only that 
the headphones output is not doing any noise and then the internal 
speakers are not muted. With mplayer and ALSA sound output the CPU load 
goes very high and it stutters, with OSS output in mplayer OSS device 
not more.

This is an new DELL Inspiron 9400 Dual Core notebook with Sigmatel STAC 
92XX C-Major HD Audio.

lspci:
00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High 
Definition Audio Controller (rev 01) Subsystem: Dell Unknown device 01cd

Module options:
snd_hda_intel position_fix=1 index=0

What has changed since 2.6.15.X?


Greetings,
Marcus
