Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317193AbSFWX5U>; Sun, 23 Jun 2002 19:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317194AbSFWX5Q>; Sun, 23 Jun 2002 19:57:16 -0400
Received: from anchor-post-32.mail.demon.net ([194.217.242.90]:37386 "EHLO
	anchor-post-32.mail.demon.net") by vger.kernel.org with ESMTP
	id <S317193AbSFWX5P>; Sun, 23 Jun 2002 19:57:15 -0400
Subject: PATCH] linux-2.5.24 - LDM (Dynamic Disks)
From: Richard Russon <ldm@flatcap.org>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7.99 
Date: 24 Jun 2002 00:57:15 +0100
Message-Id: <1024876637.20371.37.camel@whiskey.something.uk.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

[copy sent to Linus with inline patch]

Please can you apply the following patch to 2.5.24.

It's a complete rewrite of the LDM driver (support for Windows Dynamic
Disks).  Below is a one line summary, a full description and the patch.


LDM Driver rewritten.  More efficient.  Much smaller memory footprint.


The old driver was little more than a stopgap.
The new driver is a complete rewrite
based on a much better understanding of the database
based on much more reverse engineering
more able to spot errors and inconsistancies
it has a much smaller memory footprint
no longer considered experimental
accompanied by brief info: Documentation/ldm.txt


Documentation/00-INDEX    |    2 
Documentation/ldm.txt     |  102 ++
fs/partitions/Config.help |    5 
fs/partitions/Config.in   |    2 
fs/partitions/ldm.c       | 2220 +++++++++++++++++++++++++++-------------------
fs/partitions/ldm.h       |  206 ++--

  http://linux-ntfs.sf.net/ldm/linux-2.5.24-ldm.gz

Cheers,
  FlatCap - Richard Russon
  ldm@flatcap.org


