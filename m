Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264887AbSJ3TrY>; Wed, 30 Oct 2002 14:47:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264888AbSJ3TrY>; Wed, 30 Oct 2002 14:47:24 -0500
Received: from smtp3.us.dell.com ([143.166.148.134]:55046 "EHLO
	smtp3.us.dell.com") by vger.kernel.org with ESMTP
	id <S264887AbSJ3TrW>; Wed, 30 Oct 2002 14:47:22 -0500
Date: Wed, 30 Oct 2002 13:53:45 -0600 (CST)
From: Matt Domsch <Matt_Domsch@Dell.com>
X-X-Sender: mdomsch@humbolt.us.dell.com
Reply-To: Matt Domsch <Matt_Domsch@Dell.com>
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH 2.5.44] EDD updates
Message-ID: <Pine.LNX.4.44.0210301351180.27031-100000@humbolt.us.dell.com>
X-GPG-Fingerprint: 17A4 17D0 81F5 4B5F DB1C  AEF8 21AB EEF7 92F0 FC09
X-GPG-Key: http://domsch.com/mdomsch_pub.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do a

	bk pull http://mdomsch.bkbits.net/linux-2.5-edd-tolinus

This will update the following files:

 arch/i386/boot/setup.S   |   34 +++++-
 arch/i386/kernel/edd.c   |  231 ++++++++++++++++++++++-------------------------
 arch/i386/kernel/setup.c |    3 
 include/asm-i386/edd.h   |    4 
 4 files changed, 143 insertions, 129 deletions

through these ChangeSets:

<Matt_Domsch@dell.com> (02/10/24 1.808.5.4)
   EDD: moved attr_test to edd_attribute ->test(), comments


(Changesets below were also incorporated in 2.5.44-ac3)

<Matt_Domsch@dell.com> (02/10/23 1.808.5.3)
   EDD: remove list_head from edd_device, don't delete symlinks
   
   Update comments
   Remove list_head from edd_device, don't delete it
   Don't delete symlinks - driverfs_remove_dir() will.

<Matt_Domsch@dell.com> (02/10/23 1.808.5.2)
   EDD: cleanups
   
   print PCI info as %02x.%02x.%d
   Don't warn about nonexistant SCSI devices if it's not a SCSI device

<Matt_Domsch@dell.com> (02/10/21 1.808.5.1)
   EDD: add comments, magic value defines, use snprintf always


Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer, Architect
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com


