Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130253AbRBZOek>; Mon, 26 Feb 2001 09:34:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130294AbRBZOb6>; Mon, 26 Feb 2001 09:31:58 -0500
Received: from zeus.kernel.org ([209.10.41.242]:53191 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130298AbRBZOaH>;
	Mon, 26 Feb 2001 09:30:07 -0500
From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: linux-kernel@vger.kernel.org
Date: Mon, 26 Feb 2001 10:21:51 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: 2.2.18/ext2: special file corruption?
Message-ID: <3A9A2E3D.9135.8E1BCE@localhost>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I had an interesting effect: Due to NVdriver I had a lot of system 
freezes, and I had to reboot. Using e2fsck 1.19a (SuSE 7.1) I got the 
message that one specific "Special (device/socket/fifo) inode .. has 
non-zero size. FIXED."

Interestingly I got the message for every reboot. So either the kernel 
corrupts the very same inode every time, or e2fsck does not really fix 
it, or the error simply doesn't exist. I think the kernel doesn't 
temporarily set the size to non-zero, so this seems strange.

Regards,
Ulrich

