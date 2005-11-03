Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030309AbVKCEad@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030309AbVKCEad (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 23:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030328AbVKCEac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 23:30:32 -0500
Received: from smtp112.sbc.mail.re2.yahoo.com ([68.142.229.93]:51319 "HELO
	smtp112.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030309AbVKCEac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 23:30:32 -0500
Message-Id: <20051103042121.394220000.dtor_core@ameritech.net>
Date: Wed, 02 Nov 2005 23:21:21 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Vojtech Pavlik <vojtech@ucw.cz>
Subject: [patch 0/7] Another input update
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please consider pulling from:

	www.kernel.org/pub/scm/linux/kernel/git/dtor/input.git

The main change is that now input core refuses to register input
devices that were not dynamically allocated to prevent an OOPS
when attaching input interfaces to such devices.

Changelog:
	Input: convert dmasound_awacs (OSS) to dynamic input allocation
		(Ian Wienand)
	Input: locomokbd - convert to dynamic input allocation
	Input: do not register statically allocated devices
	Input: fix input device deregistration
	Input: locomokbd - fix wrong bustype
	Input: logips2pp - add support for MX3100
	Input: lkkbd - miscellaneous fixes

Vojtech, please bless the pull.

Thanks!

--
Dmitry



