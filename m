Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161017AbWBYQ2d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161017AbWBYQ2d (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 11:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964775AbWBYQ2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 11:28:33 -0500
Received: from correo.gobiernodecanarias.org ([82.150.2.66]:63388 "EHLO
	yaiza.gobiernodecanarias.org") by vger.kernel.org with ESMTP
	id S964774AbWBYQ2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 11:28:32 -0500
Date: Sat, 25 Feb 2006 16:28:30 +0000 (GMT)
From: Lucas Quintana Rodriguez <lucasquintana@canarias.org>
Subject: keyboard and keycodes at boot time
To: linux-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Message-id: <3066031b9b.31b9b30660@canarias.org>
MIME-version: 1.0
X-Mailer: iPlanet Messenger Express 5.2 Patch 2 (built Jul 14 2004)
Content-type: text/plain; charset=us-ascii
Content-language: en
Content-transfer-encoding: 7BIT
Content-disposition: inline
X-Accept-Language: en
X-imss-version: 2.038
X-imss-result: Passed
X-imss-scores: Clean:66.18745 C:2 M:3 S:5 R:5
X-imss-settings: Baseline:2 C:4 M:4 S:4 R:4 (0.1500 0.1500)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've been trying to implement fbsplash on my computer; as you might be
concerned, this allows the user to specify background and *silent*
images to be shown at boot-time.

The nowadays oficially unmaintained Bootsplash, used to work on my
laptop back when I used 2.4.18. Now that I've switched to 2.6.10, can
notice how things has changed dramatically within the keyboard, n_tty or
related kernel layers.

The kernel says this is about my keyboard:

input: AT Translated Set 2 keyboard on isa0060/serio0

But even when I've got event interface compiled into my kernel (together
with event debugging), I'm not able to catch any key-press event till
the keyboard's been recognized by the input driver in this case.

I'm wondering whether is it possible at all to revert the situation so I
can catch again key-press events at boot-time, and still comply with the
actual kernel architecture as of 2.6.10.

I would really appreciate if someone could point me on where to start
from, or what to do about this.

Kind Regards, 

