Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264953AbUE0SZE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264953AbUE0SZE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 14:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264990AbUE0SZD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 14:25:03 -0400
Received: from spy23.spymac.net ([213.218.8.223]:19672 "EHLO spy23.spymac.net")
	by vger.kernel.org with ESMTP id S264953AbUE0SYJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 14:24:09 -0400
Subject: [2.6.7-rc1-mm1] cant mount reiserfs using -o barrier=flush
From: =?ISO-8859-1?Q?G=FCnther?= Persoons <gunther_persoons@spymac.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1085689455.7831.8.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 27 May 2004 22:24:15 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,
When i mount my reiser partitie with the option barrier=flush i get
following message and error:
My harddrive is a 2.5 inch Fujitsu 20GB IDE.

mount /dev/hda10 /tmp -o barrier=flush
mount: wrong fs type, bad option, bad superblock on /dev/hda10,
       or too many mounted file systems
Log:
ReiserFS: hda10: found reiserfs format "3.6" with standard journal
ReiserFS: hda10: using ordered data mode
reiserfs: using flush barriers
ReiserFS: hda10: journal params: device hda10, size 8192, journal first
block 18, max trans len 1024, max batch 900, max commit age 30, max
trans age 30
ReiserFS: hda10: checking transaction log (hda10)
hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
hda: drive_cmd: error=0x04 { DriveStatusError }
hda: barrier support doesn't work
ReiserFS: hda10: warning: journal-837: IO error during journal replay
ReiserFS: hda10: warning: Replay Failure, unable to mount
ReiserFS: hda10: warning: sh-2022: reiserfs_fill_super: unable to
initialize journal space
-- 
Günther Persoons <gunther_persoons@spymac.com>

