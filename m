Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267165AbTAKIor>; Sat, 11 Jan 2003 03:44:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267166AbTAKIor>; Sat, 11 Jan 2003 03:44:47 -0500
Received: from outbound04.telus.net ([199.185.220.223]:36035 "EHLO
	priv-edtnes28.telusplanet.net") by vger.kernel.org with ESMTP
	id <S267165AbTAKIoq>; Sat, 11 Jan 2003 03:44:46 -0500
Subject: Partition full BUG?
From: Bob <gillb4@telusplanet.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 11 Jan 2003 01:54:24 -0700
Message-Id: <1042275265.24317.63.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.  I have looked for an answer to a question all over the net and
haven't found an answer.  Hopefully someone here can answer it.  When
modifying a file on a nearly full disk partition, if the opened file
can't contain all of the data appended to it, the whole file is
truncated to zero bytes (only the filename remains).  Is that supposed
to happen?  (The partition is /boot, the filesystem ext3, the file is
grub.conf).  It just seems like it would be better if it reported an
error like '/dev/hda1 full' and left the file intact.
   
Thanks in advance,

Bob.  

