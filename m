Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317391AbSGDLuA>; Thu, 4 Jul 2002 07:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317392AbSGDLt7>; Thu, 4 Jul 2002 07:49:59 -0400
Received: from ds217-115-141-141.dedicated.hosteurope.de ([217.115.141.141]:25348
	"EHLO ds217-115-141-141.dedicated.hosteurope.de") by vger.kernel.org
	with ESMTP id <S317391AbSGDLt7>; Thu, 4 Jul 2002 07:49:59 -0400
Date: Thu, 4 Jul 2002 13:52:31 +0200
From: Jochen Suckfuell <jo-lkml@suckfuell.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Disk IO statistics still buggy
Message-ID: <20020704135231.A17481@ds217-115-141-141.dedicated.hosteurope.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

The IO statistics displayed in /proc/partitions are still buggy, because
after some time, the value for the currently running requests gets too
high or too low (see the archives, look for "/proc/partitions").

Is anyone working on a fix?

Or does someone have an idea where the error might occur?
Which parts of the kernel play a role in starting/stopping block IO
requests (that are not part of ll_rw_blk.c) and might not handle the
accounting correctly?

I'd like to fix this and would appreciate any pointers, since after a
first look there is no obvious error in ll_rw_blk.c .

Thanks in advance,

Jochen Suckfuell

