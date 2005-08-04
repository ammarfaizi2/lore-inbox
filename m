Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262649AbVHDToZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262649AbVHDToZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 15:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262634AbVHDToQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 15:44:16 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:58309 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262644AbVHDToD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 15:44:03 -0400
Subject: [GIT PATCH] scsi bug fixes for 2.6.13
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Date: Thu, 04 Aug 2005 14:43:54 -0500
Message-Id: <1123184634.5026.58.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is my (hopefully final) collection of safe driver updates and bug
fixes for 2.6.13.

The tree is available from

rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jejb/scsi-for-
linus-2.6.git

The short changelog is

Andrew Morton:
  o fc4 warning fix

Jack Hammer:
  o ServeRAID V7.12.02

James Bottomley:
  o fix aic7xxx performance issues since 2.6.12-rc2
  o aic7xxx: final fixes for DT handling
  o aic7xxx: fix bug in DT handing

Kai Mäkisara:
  o Fix SCSI tape oops at module removal

Linda Xie:
  o scsi/ibmvscsi/srp.h: Fix a wrong type code used for SRP_LOGIN_REJ

And the diffstat:

 fc4/fc.c                   |    2 +-
 scsi/aic7xxx/aic7xxx_osm.c |   24 +++++++++++-------------
 scsi/ibmvscsi/srp.h        |    2 +-
 scsi/ips.c                 |    8 +++++---
 scsi/ips.h                 |   39 +++++++++++++++++++++------------------
 scsi/st.c                  |    8 ++------
 6 files changed, 41 insertions(+), 42 deletions(-)

James


