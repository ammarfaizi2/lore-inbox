Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261364AbSL2TES>; Sun, 29 Dec 2002 14:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261368AbSL2TER>; Sun, 29 Dec 2002 14:04:17 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:8887 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261364AbSL2TER> convert rfc822-to-8bit; Sun, 29 Dec 2002 14:04:17 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: WOLK - Working Overloaded Linux Kernel
To: linux-kernel@vger.kernel.org
Subject: RAID0 problems with 2.4.21-BK current
Date: Sun, 29 Dec 2002 20:12:11 +0100
User-Agent: KMail/1.4.3
Cc: Neil Brown <neilb@unsw.edu.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200212292012.11556.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

this:

http://linux.bkbits.net:8080/linux-2.4/patch@1.884.1.69?nav=index.html|ChangeSet@-2w|cset@1.884.1.69

patch breaks at least RAID 0 recognition at boottime (infinite loop) and also 
breaks mkraid /dev/md0. Never stops, State D.

Ripping the patch out helps.

ciao, Marc
