Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964906AbWIRHpW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964906AbWIRHpW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 03:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964937AbWIRHpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 03:45:22 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:48806 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S964906AbWIRHpV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 03:45:21 -0400
Date: Mon, 18 Sep 2006 09:44:54 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Pavel Machek <pavel@ucw.cz>
cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 8 hours of battery life on thinkpad x60
In-Reply-To: <20060917194118.GA3477@elf.ucw.cz>
Message-ID: <Pine.LNX.4.61.0609180939270.23599@yvahk01.tjqt.qr>
References: <20060917194118.GA3477@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>I did a presentation about getting 8 hours of runtime out of common
>notebooks. You can get it at

So if I use an uncommon notebook with an uncommon battery (SONY 
PCGA-BP3U - 59070 mWh - 7 hours average) how much more am I supposed to 
get?

# cd /proc/acpi/battery/BAT1
# cat info
present:                 yes
design capacity:         59940 mWh
last full capacity:      59070 mWh
battery technology:      non-rechargeable
design voltage:          11100 mV
design capacity warning: 0 mWh
design capacity low:     120 mWh
capacity granularity 1:  0 mWh
capacity granularity 2:  10 mWh
model number:
serial number:
battery type:            LION
OEM info:                Sony Corp.
# cat state
present:                 yes
capacity state:          ok
charging state:          discharging
present rate:            8029 mW (currently WLAN + Webradio)
remaining capacity:      46320 mWh
present voltage:         11826 mV


Jan Engelhardt
-- 
