Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266238AbUGJMs3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266238AbUGJMs3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 08:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266240AbUGJMs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 08:48:28 -0400
Received: from mail.aei.ca ([206.123.6.14]:49652 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S266238AbUGJMsU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 08:48:20 -0400
From: Ed Tomlinson <edt@aei.ca>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: 2.6.7-mm7 ide errors
Date: Sat, 10 Jul 2004 08:48:15 -0400
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407100848.15665.edt@aei.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The ide error introduced with the barrier patches are still happening here with mm7. 

Jul 10 08:06:04 bert usb.agent[1705]:      usbhid: loaded successfully
Jul 10 08:06:04 bert input.agent[1738]:      joydev: loaded successfully
Jul 10 08:06:06 bert kernel: lp: driver loaded but no devices found
Jul 10 08:06:16 bert kernel: hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
Jul 10 08:06:16 bert kernel: hda: drive_cmd: error=0x04 { DriveStatusError }
Jul 10 08:06:16 bert kernel: ide: failed opcode was: 0xe7
Jul 10 08:06:18 bert kernel: hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
Jul 10 08:06:18 bert kernel: hda: drive_cmd: error=0x04 { DriveStatusError }
Jul 10 08:06:18 bert kernel: ide: failed opcode was: 0xe7

Typically  I get one of the above every couple of minutes and have since the barrier changes
when into mm.

What can I do to help get to the bottom of this problem?

Ed Tomlinson
