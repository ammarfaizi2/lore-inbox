Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261185AbVCFBe2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261185AbVCFBe2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 20:34:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261267AbVCFBe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 20:34:27 -0500
Received: from a26.t1.student.liu.se ([130.236.221.26]:27300 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S261185AbVCFBeZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 20:34:25 -0500
Message-ID: <422A5E1C.2050107@drzeus.cx>
Date: Sun, 06 Mar 2005 02:34:20 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: LKML <linux-kernel@vger.kernel.org>, Ian Molton <spyro@f2s.com>,
       Richard Purdie <rpurdie@rpsys.net>
Subject: [PATCH][MMC][0/6] Secure Digital (SD) support
References: <422701A0.8030408@drzeus.cx> <20050305113730.B26541@flint.arm.linux.org.uk> <4229A4B4.1000208@drzeus.cx> <20050305124420.A342@flint.arm.linux.org.uk>
In-Reply-To: <20050305124420.A342@flint.arm.linux.org.uk>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As promised, here is the patch broken down into smaller pieces. The 
patch is now divided into six distinct parts:

* Protocol definitions.
* SD card initialisation.
* Reading read-only switch.
* Getting SCR register.
* Exposing SCR register through sysfs.
* Wide (4-bit) bus support.

Rgds
Pierre
