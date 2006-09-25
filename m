Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751462AbWIYLqP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462AbWIYLqP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 07:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751466AbWIYLqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 07:46:15 -0400
Received: from calculon.skynet.ie ([193.1.99.88]:1988 "EHLO calculon.skynet.ie")
	by vger.kernel.org with ESMTP id S1751462AbWIYLqO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 07:46:14 -0400
Date: Mon, 25 Sep 2006 12:46:12 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet.skynet.ie
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [git pull] intelfb tree for 2.6.18-rc1
Message-ID: <Pine.LNX.4.64.0609251245280.17428@skynet.skynet.ie>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

This is an update to the Intel Framebuffer driver with i2c support for the
intelfb and vsync support, along with some annotation fixing by Al.

Please pull from 'intelfb-patches' branch of
master.kernel.org:/pub/scm/linux/kernel/git/airlied/intelfb-2.6.git intelfb-patches

to receive the following updates:

  Documentation/fb/intelfb.txt        |   11 +-
  drivers/video/Kconfig               |   26 ++++-
  drivers/video/intelfb/Makefile      |    4 +
  drivers/video/intelfb/intelfb.h     |   81 ++++++++++++++
  drivers/video/intelfb/intelfb_i2c.c |  200 +++++++++++++++++++++++++++++++++++
  drivers/video/intelfb/intelfbdrv.c  |   82 +++++++++++++-
  drivers/video/intelfb/intelfbhw.c   |  160 +++++++++++++++++++++++++---
  drivers/video/intelfb/intelfbhw.h   |   25 ++++
  include/linux/i2c-id.h              |    1
  9 files changed, 555 insertions(+), 35 deletions(-)
  create mode 100644 drivers/video/intelfb/intelfb_i2c.c

Al Viro:
       intelfb delousing

Christian Merkle:
       intelfb: update doc and Kconfig (supported devices)

Dave Airlie:
       intelfb: fix mtrr_reg signedness

Dennis Munsie:
       intelfb: add preliminary i2c support
       intelfb: add preliminary i2c support
       intelfb: add preliminary i2c support
       intelfb: add preliminary i2c support
       intelfb: add preliminary i2c support
       intelfb: add preliminary i2c support
       intelfb: add preliminary i2c support
       intelfb: add preliminary i2c support

Eric Hustvedt:
       intelfb: add vsync interrupt support
       intelfb: add vsync interrupt support
       intelfb: add vsync interrupt support
       intelfb: add vsync interrupt support
       intelfb: add vsync interrupt support

Parag Warudkar:
       intelfbhw.c: intelfbhw_get_p1p2 defined but not used


