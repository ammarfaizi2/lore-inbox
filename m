Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277132AbRJLApD>; Thu, 11 Oct 2001 20:45:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277130AbRJLAox>; Thu, 11 Oct 2001 20:44:53 -0400
Received: from mackman.submm.caltech.edu ([131.215.85.46]:384 "EHLO
	mackman.net") by vger.kernel.org with ESMTP id <S277129AbRJLAoq>;
	Thu, 11 Oct 2001 20:44:46 -0400
Date: Thu, 11 Oct 2001 17:45:17 -0700 (PDT)
From: Ryan Mack <rmack@mackman.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [QUESTION] Stopping RAID devices from Magic SysRq?
Message-ID: <Pine.LNX.4.33.0110111739050.934-100000@mackman.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was curious if anyone has previosly considered adding a raid-stop
functionality to the magic sysrq command?  I realize that a full raid-stop
would make the partition unavailable for read-only access, which may
require the system to be immediately reset.  Is there a mechanism to
remount a raid device read-only if all mounts from it are read-only (i.e.,
marking the raid superblock clean, syncing, and then only allowing
read-only access)?

Thanks, Ryan


