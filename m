Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265590AbSJSMgH>; Sat, 19 Oct 2002 08:36:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265591AbSJSMgH>; Sat, 19 Oct 2002 08:36:07 -0400
Received: from [217.78.194.34] ([217.78.194.34]:59604 "EHLO
	mgmtmmp12.dnafinland.fi") by vger.kernel.org with ESMTP
	id <S265590AbSJSMgH>; Sat, 19 Oct 2002 08:36:07 -0400
Date: Sat, 19 Oct 2002 15:41:55 +0300
From: as@sci.fi
Subject: Recovering data from a damaged ext2 partition?
To: linux-kernel@vger.kernel.org
Message-id: <2.1-506535-380-A-OEWW@smtp.dna044.com>
MIME-version: 1.0
X-Mailer: Eudora 2.1 for PalmOS
Content-type: text/plain; format=flowed
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a somewhat broken disk with some data I'd like to get back. I've 
run badblocks and according to it, most of the partition is ok, but 
apparently inode 2 and hence the root dir is unreadabe and so debugfs 
   can't seem to be able to do much.

Is there anything else I can do in this situation?
