Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269925AbTGPAB7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 20:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269933AbTGPAB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 20:01:58 -0400
Received: from [66.62.77.7] ([66.62.77.7]:61912 "EHLO mail.gurulabs.com")
	by vger.kernel.org with ESMTP id S269925AbTGPAB4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 20:01:56 -0400
Date: Tue, 15 Jul 2003 18:16:46 -0600 (MDT)
From: Dax Kelson <dax@gurulabs.com>
X-X-Sender: dkelson@mooru.gurulabs.com
To: linux-kernel@vger.kernel.org
Subject: Synaptics Touchpad 2.6.0-test1 problem
Message-ID: <Pine.LNX.4.44.0307151809380.31633-100000@mooru.gurulabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm using XFree86-4.3.0-17, I have the synaptics XF86 0.11.3p6 driver 
installed.

I have input, evdev, mousedev, psmouse in the kernel.

I get happy dmesg output when psmouse loads.

When X starts the cursor sits in the middle of the screen and won't move 
when I touch the touchpad or the buttons.

On the TTY from which I started the X server I see:

Synaptics DeviceInit called
SynapticsCtrl called
Synaptics DeviceOn called
SynapticsCtrl called
SynapticsCtrl called
Synaptics DeviceOff called

This last message looks suspicious. I dunno, maybe it's normal.  Either 
way the touchpad doesn't work.

Dax

