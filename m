Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318168AbSHPEyk>; Fri, 16 Aug 2002 00:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318169AbSHPEyj>; Fri, 16 Aug 2002 00:54:39 -0400
Received: from sccrmhc01.attbi.com ([204.127.202.61]:37284 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S318168AbSHPEyj>; Fri, 16 Aug 2002 00:54:39 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Ivan Gyurdiev <ivangurdiev@attbi.com>
Reply-To: ivangurdiev@attbi.com
Organization: ( )
To: LKML <linux-kernel@vger.kernel.org>
Subject: Floppies under 2.5.
Date: Tue, 13 Aug 2002 09:07:23 -0400
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200208130907.23127.ivangurdiev@attbi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My floppy refuses to mount under 2.5.31.
The first attempt leads to segmentation fault.
The second attempt leads to an unkillable
(killall -9 mount as root has no effect) process which freezes on the 
open call:

stat64("/dev/fd0", {st_mode=S_IFBLK|0660, st_rdev=makedev(2, 0), ...}) = 0
open("/dev/fd0", O_RDONLY|O_LARGEFILE
========================

Mounting floppies works fine under 2.4.




