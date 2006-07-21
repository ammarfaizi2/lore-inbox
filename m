Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030453AbWGUEEQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030453AbWGUEEQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 00:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030455AbWGUEEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 00:04:16 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:18838 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1030454AbWGUEEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 00:04:16 -0400
Date: Fri, 21 Jul 2006 06:04:30 +0200
From: Pavel Machek <pavel@ucw.cz>
To: rlove@rlove.org, kernel list <linux-kernel@vger.kernel.org>
Subject: hdaps driver on x60
Message-ID: <20060721040430.GA2507@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Driver seems to load but does not seem to produce any useful data:

pavel@amd:/data/l/linux$ dmesg | grep hdaps
hdaps: inverting axis readings.
hdaps: Lenovo ThinkPad X60 detected.
PM: Adding info for platform:hdaps
input: hdaps as /class/input/input3
hdaps: driver successfully loaded.
pavel@amd:/data/l/linux$

root@amd:~# /home/pavel/sf/linuxconsole-ruby/utils/./evtest
/dev/input/event3
Input driver version is 1.0.0
Input device ID: bus 0x0 vendor 0x0 product 0x0 version 0x0
Input device name: "hdaps"
Supported events:
  Event type 0 (Sync)
  Event type 3 (Absolute)
    Event code 0 (X)
      Value      0
      Min     -256
      Max      256
      Fuzz       4
      Flat       4
    Event code 1 (Y)
      Value      0
      Min     -256
      Max      256
      Fuzz       4
      Flat       4
Testing ... (interrupt to exit)


...any ideas? /sys interface also shows same values all the time...

									Pavel
-- 
Thanks, Sharp!
