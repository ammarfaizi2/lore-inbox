Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262574AbUCOOAd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 09:00:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262575AbUCOOAd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 09:00:33 -0500
Received: from catbert.ams.sunysb.edu ([129.49.108.32]:35017 "EHLO
	catbert.ams.sunysb.edu") by vger.kernel.org with ESMTP
	id S262574AbUCOOAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 09:00:32 -0500
To: zwane@holomorphy.com
Cc: linux-kernel@vger.kernel.org
Subject: watchdog on A7M266-D motherboard
X-URL: http://www.ams.sunysb.edu/~pekon/
From: Petr Konecny <pekon@ams.sunysb.edu>
Date: Mon, 15 Mar 2004 09:00:13 -0500
Message-ID: <tlcad2iqkgi.fsf@cg.ams.sunysb.edu>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am trying to use watchdog to reboot my computer when it freezes. I was
wondering if amd7xx_tco is supposed to work in Asus A7M266-D
motherboard. It seems to load fine and GETTIMEOUT return values
decrement in one second intervals. However when the timer reaches 0
nothing happens, it just rolls over to 37 and keeps going. Even a simple
program that opens /dev/watchdog and sleeps forever, does not reboot the
computer.

I am currently running 2.6.4-mm2, but can test suggested
versions/patches.  Any hints ?

                                                Thanks, Petr
-- 
The end move in politics is always to pick up a gun.
		-- Buckminster Fuller
