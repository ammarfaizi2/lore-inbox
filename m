Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262878AbTLOBIf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 20:08:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262888AbTLOBIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 20:08:35 -0500
Received: from 66.159.164.68.adsl.snet.net ([66.159.164.68]:44433 "EHLO
	mail.bscnet.com") by vger.kernel.org with ESMTP id S262878AbTLOBId
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 20:08:33 -0500
Message-ID: <01a901c3c2a7$f5d8a9d0$0900a8c0@BOBHITT>
From: "Bobby Hitt" <Robert.Hitt@bscnet.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Need Quota Support for Reiserfs Partition
Date: Sun, 14 Dec 2003 20:08:33 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm using Slackware Linux with kernel version 2.6.0-test11. All of my
partitions are Rieserfs. I now have a need to use quotas on a partition, but
according to the help screen using "make menuconfig" quotas are only
available under the ext2 file systems. Is there a patch to allow quotas
under rieserfs? One of my searches said that Reiserfs and quotas were
supported under 2.6.0, but when I try and mount the partition with this line
in /etc/fstab:

/dev/hde2 /downloads reiserfs defaults,usrquota,grpquota 1 2

I get this error:

mount: wrong fs type, bad option, bad superblock on /dev/hde2,
       or too many mounted file systems


If I take the usrquota,grpquota off, the mount works fine.

TIA,

Bobby

