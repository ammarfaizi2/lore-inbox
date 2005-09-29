Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932163AbVI2OTh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163AbVI2OTh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 10:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932164AbVI2OTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 10:19:37 -0400
Received: from 122.0.203.62.cust.bluewin.ch ([62.203.0.122]:1324 "EHLO
	kestrel.twibright.com") by vger.kernel.org with ESMTP
	id S932163AbVI2OTh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 10:19:37 -0400
Date: Thu, 29 Sep 2005 16:19:24 +0200
From: Karel Kulhavy <clock@twibright.com>
To: linux-kernel@vger.kernel.org
Subject: CD writer is burning with open tray
Message-ID: <20050929141924.GA6512@kestrel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Orientation: Gay
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I ran cdrecord -tao dev=ATAPI:0,0,0 speed=8 /home/clock/cdrom.iso on
2.6.12-gentoo-r10 and it burned a good CD.

Then I repeated the same command (press up and enter) and it
1) Burned two bad CD's with a strip near the central area
2) Third CD burned bad
3) When rerun cdrecord says
cdrecord: Drive does not support TAO recording.
cdrecord: Illegal write mode for this drive.

I should note here that I didn't hotplug the hardware - I can't
understand how supported modes can change on the fly...

Anyway the activity LED is now flashing (later shining) even when
cdrecord is not running and I open the tray using emergency open
(it cannot be opened by normal open). /dev/hdc (the CDROM) is not mounted.
The mechanics inside is quite heated up.

The activity LED is flashing or shining even when the mechanics is open
and I can look into the laser lens!  However I didn't see any dim red
light - looks like the laser switches off when the tray is open.

Is it possible to get eye damage due to faulty kernel driver?

Is it possible to destroy the mechanics by overheating or mechanical
damage due to faulty kernel driver?

Is this intended behaviour of Linux kernel?

CL<
