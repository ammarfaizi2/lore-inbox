Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262524AbTFGCrZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 22:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262530AbTFGCrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 22:47:25 -0400
Received: from mail.casabyte.com ([209.63.254.226]:26892 "EHLO
	mail.1casabyte.com") by vger.kernel.org with ESMTP id S262524AbTFGCrY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 22:47:24 -0400
From: "Robert White" <rwhite@casabyte.com>
To: <linux-kernel@vger.kernel.org>
Subject: VFAT Defragmentation under Linux
Date: Fri, 6 Jun 2003 20:00:57 -0700
Message-ID: <PEEPIDHAKMCGHDBJLHKGOELGCOAA.rwhite@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4920.2300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I understand that the current file system drivers for the primary file
system types have anti-fragmentation logic built into them already.  (e.g.
ext2/3 moves things around and such while the file system is mounted.)

Do the VFAT drivers likewise defragment the VFAT partitions?

If not, is there a Linux-hosted defragment program for defragmenting an
unmounted VFAT partition?

If such exists I have been unable to find it via normal network searches
because the dos/windows tools raise the noise floor on "VFAT defragment" so
high that no other refinements seem to hit.

So far the only Linux-level defragment operation that I seem to have
available for a VFAT partition is to mount the drive, cpio everything off of
it, delete its contents, and then copy everything back.  That's a little
drastic and has obvious issues if you want to then boot that partition
separately/later.

Rob.

