Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261890AbTLNOCf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 09:02:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261891AbTLNOCf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 09:02:35 -0500
Received: from law11-f40.law11.hotmail.com ([64.4.17.40]:17420 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S261890AbTLNOCe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 09:02:34 -0500
X-Originating-IP: [217.232.144.184]
X-Originating-Email: [a_r_a_k_i_s@hotmail.com]
From: "Arakis -" <a_r_a_k_i_s@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: alsa i8x0 driver bug in kernel newer than 2.6test1
Date: Sun, 14 Dec 2003 14:02:32 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Message-ID: <LAW11-F40dyZqUCx2Uv00036437@hotmail.com>
X-OriginalArrivalTime: 14 Dec 2003 14:02:33.0238 (UTC) FILETIME=[EB967360:01C3C24A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this is my first bug report, I hope I don't leave out any vital information.

The ALSA driver for i8x0 sound cards has a minor bug in all 2.6 test 
versions except test1. The sounds "lags" sporadically for a few seconds. 
It's not a total stop of playback, the speed is even increased a little bit. 
It just sounds weird... at first I thought it has something todo with the 
scheduler, but since nice -20 has no effect at all, I doubt it. The problem 
occurs with xmms and mpg123.

cat /proc/asound/cards:
0 [I82801CAICH3   ]: ICH - Intel 82801CA-ICH3
                     Intel 82801CA-ICH3 at 0x1400, irq 10

The machine is a toshiba 5200-701 notebook (european), 1.9 GHz Pentium4, 512 
MB RAM, average cpu usage is ~5% during playback (according to gkrellm). The 
driver is compiled into the kernel (=Y).

_________________________________________________________________
5 neue Buddies = 50 FreeSMS. http://messenger-mania.msn.de MSN Messenger 
empfehlen und kräftig abräumen!

