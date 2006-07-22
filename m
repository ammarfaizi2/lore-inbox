Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751311AbWGVMMk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311AbWGVMMk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 08:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbWGVMMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 08:12:40 -0400
Received: from pih-relay05.plus.net ([212.159.14.132]:2483 "EHLO
	pih-relay05.plus.net") by vger.kernel.org with ESMTP
	id S1751311AbWGVMMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 08:12:39 -0400
Message-ID: <44C21635.5090808@mauve.plus.com>
Date: Sat, 22 Jul 2006 13:12:37 +0100
From: Ian Stirling <tandra@mauve.plus.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: USB snd-usb-audio wedges lsusb when unplugged while playing sound.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Config/... as my earlier message on USB - though with the bandwidth 
enforcement
turned off so it actually plays sound, when plugged into the USB1 port.

2.6.17.

Basically - playing sound with
mplayer -ao alsa:device=hw=1 or whatever - and then unplugging the
soundcard completely wedges lsusb/usb configuration, until the mplayer 
process is killed.

cat /proc/bus/usb/devices stalls.
