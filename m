Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263417AbTC2N5j>; Sat, 29 Mar 2003 08:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263418AbTC2N5i>; Sat, 29 Mar 2003 08:57:38 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:1540 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id <S263417AbTC2N5i>; Sat, 29 Mar 2003 08:57:38 -0500
From: john@grabjohn.com
Message-Id: <200303291411.h2TEBUcO000138@81-2-122-30.bradfords.org.uk>
Subject: Root image spanning multiple floppies broken?
To: linux-kernel@vger.kernel.org
Date: Sat, 29 Mar 2003 14:11:30 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just tried loading a root fs image spanning five disks on 2.4.21-pre6
and 2.4.20, and it fails.

The first disk loads OK, but the second disk is accessed only briefly,
and then the prompt for disk three appears.  If you _don't_ switch
disks, the second disk, (which is actually the first disk, obviously),
is read correctly.

This happens on at least two machines here.

John.
