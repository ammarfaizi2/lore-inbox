Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268776AbUIQOZB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268776AbUIQOZB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 10:25:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268799AbUIQOWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 10:22:35 -0400
Received: from mail.convergence.de ([212.227.36.84]:15262 "EHLO
	email.convergence2.de") by vger.kernel.org with ESMTP
	id S268776AbUIQOV7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 10:21:59 -0400
Message-ID: <414AF2CA.3000502@linuxtv.org>
Date: Fri, 17 Sep 2004 16:20:58 +0200
From: Michael Hunold <hunold@linuxtv.org>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH][2.6][0/14] DVB subsystem update
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

here comes a patchset consisting of 14 patches bringing the in-kernel 
DVB subsystem in sync with the LinuxTV.org CVS driver.

The most important changes include:
- remove non-linux compatibility stuff
- remove home-brewn dvb-i2c stuff, use kernel-i2c instead
- convert home-brewn bttv i2c access drivers to real bttv sub-drivers
- add new driver for mobile USB Budget DVB-T devices by DiBcom
- add new drivers for Zarlink DVB-T MT352 frontend, Conexant 22702 DVB 
OFDM frontend and DVB-T demodulator DiBcom 3000-MB frontend
- plus lots of other changes, explained in the top of each patch.

Please apply. Thanks!

Regards.
Michael Hunold.
