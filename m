Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbTIMK3h (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 06:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262117AbTIMK3h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 06:29:37 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:7655 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S262116AbTIMK3f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 06:29:35 -0400
To: <linux-kernel@vger.kernel.org>
Cc: Peter Osterlund <petero2@telia.com>
Subject: Re: 2.6.0-test5 (nearly) success story - Synaptics touchpad
References: <m3k78enooi.fsf@defiant.pm.waw.pl>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 13 Sep 2003 12:27:47 +0200
In-Reply-To: <m3k78enooi.fsf@defiant.pm.waw.pl>
Message-ID: <m365jxaspo.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

another thing: the Synaptics touchpad doesn't work:

mice: PS/2 mouse device common for all mice
input: PC Speaker
Synaptics Touchpad, model: 1
 Firware: 4.6
 Sensor: 19
 new absolute packet format
 Touchpad has extended capability bits
 -> multifinger detection
 -> palm detection
input: Synaptics Synaptics TouchPad on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
i2c-piix4 version 2.7.0 (20021208)


Sometimes I also get before "Synaptics Touchpad, model: 1":
synaptics reset failed
synaptics reset failed
synaptics reset failed


With 2.4 kernel it works fine as plain PS/2 mouse.
-- 
Krzysztof Halasa, B*FH
