Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262322AbUGHRvc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262322AbUGHRvc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 13:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262730AbUGHRvc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 13:51:32 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:13490 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262322AbUGHRv3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 13:51:29 -0400
From: jmerkey@comcast.net
To: linux-kernel@vger.kernel.org
Cc: jmerkey@drdos.com
Subject: Ext3 File System "Too many files" with snort
Date: Thu, 08 Jul 2004 17:51:26 +0000
Message-Id: <070820041751.25643.40ED899E0006C76E0000642B2200748184970A059D0A0306@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Jun 24 2004)
X-Authenticated-Sender: am1lcmtleUBjb21jYXN0Lm5ldA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On a Linux 2.4.21 system running snort with a very large organization (30,000 +) workstations
I am seeing a "too many files" mesage from ext3 which results in snort dying and rolling 
our of memory.  Is there a way to specifiy a larger number of inode entries dynamically 
when creating an Ext3 file system which gets around this limitation.  In theory, a file system 
should not create a limitation on how many files it can contain, but I understand that inode
base FS's have this limitation.

Also, I have discovered that I am blocked from posting to LKML from devicelogics.com and
am using an alternate email account.  What's up, did something chage are are we blocking 
folks from posting, or is ECN causing problems.

Thanks

Jeff
