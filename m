Return-Path: <linux-kernel-owner+w=401wt.eu-S1751881AbXAVQqG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751881AbXAVQqG (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 11:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751938AbXAVQqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 11:46:06 -0500
Received: from styx.suse.cz ([82.119.242.94]:49637 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751881AbXAVQqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 11:46:05 -0500
Date: Mon, 22 Jan 2007 17:44:19 +0100 (CET)
From: Jiri Kosina <jkosina@suse.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PATCH] HID fixes
Message-ID: <Pine.LNX.4.64.0701221741060.31347@jikos.suse.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

could you please pull from 'for-linus' branch of

   git://git.kernel.org/pub/scm/linux/kernel/git/jikos/hid.git for-linus

or
   master.kernel.org/pub/scm/linux/kernel/git/jikos/hid.git for-linus

to receive bugfixes for HID code.

Thanks.

--- 

 MAINTAINERS                  |    5 ++---
 drivers/hid/hid-core.c       |    6 +++++-
 drivers/hid/hid-input.c      |   20 ++++++++++++++++----
 drivers/usb/input/Kconfig    |    2 +-
 drivers/usb/input/hid-core.c |   40 ++++++++++++++++++++++++----------------
 drivers/usb/input/hid-ff.c   |    5 +++--
 drivers/usb/input/hiddev.c   |    2 +-
 drivers/usb/input/usbhid.h   |    3 +++
 include/linux/hid-debug.h    |    7 ++++---
 9 files changed, 59 insertions(+), 31 deletions(-)

Adrian Friedli (1):
      HID: GEYSER4_ISO needs quirk

Anssi Hannula (1):
      HID: put usb_interface instead of usb_device into hid->dev to fix udevinfo breakage

Jeremy Roberson (1):
      hid-core.c: Adds GTCO CalComp Interwrite IPanel PIDs to blacklist

Jiri Kosina (3):
      HID: update MAINTAINERS entry for USB-HID
      HID: compilation fix when DEBUG_DATA is defined
      HID: hid/hid-input.c doesn't need to include linux/usb/input.h

Russell King (1):
      HID: fix some ARM builds due to HID brokenness - make USB_HID depend on INPUT

Simon Budig (2):
      HID: proper LED-mapping for SpaceNavigator
      HID: add missing RX, RZ and RY enum values to hid-debug output

