Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264683AbSLBRTT>; Mon, 2 Dec 2002 12:19:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264681AbSLBRTT>; Mon, 2 Dec 2002 12:19:19 -0500
Received: from [81.2.122.30] ([81.2.122.30]:3589 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S264915AbSLBRTR>;
	Mon, 2 Dec 2002 12:19:17 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200212021737.gB2HbiGN000686@darkstar.example.net>
Subject: IDE documentation bitrot, (Was: ATAPI DMA timeouts showing up in logs)
To: trog@wincom.net
Date: Mon, 2 Dec 2002 17:37:44 +0000 (GMT)
Cc: alan@redhat.com, linux-kernel@vger.kernel.org, mlord@pobox.com
In-Reply-To: <3deb797f.41fc.0@wincom.net> from "Dennis Grant" at Dec 02, 2002 10:18:11 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Now that I've got the proper IDE driver in place (2.4.20rc4)
>>> and the master drive on the primary interface is running at
>>> a full ATA133, these have started showing up in the logs - 
>>> 2 or 3 a day:
>> My guess is its the IDE command/DMA sequence bug that Khalid
>> fixed in -ac. Some drives also take a very long time on 
>> retrying blocks and that might cause a timeout/reset too.
> OK.

>>> This last one is the only indication that something might be amiss - the
>>> two instances of "invalid argument" Other than that, the drive
>>> appears to work just fine.
>> Those are ones CD-ROM's dont support
> Ah, OK. Perhaps hdparm shouldn't try them then. :)

There have been quite a few posts to linux-kernel about IDE diagnostic
messages that people are interpreting as fatal errors when they
aren't, and I've noticed that Documentation/ide.txt hasn't been
updated much for a long time - maybe it would be worth bringing it up
to date?

Is the current maintainer Mark Lord or Marcin Dalecki?  In the 2.5.x
tree, it's had obsolete info removed, but it hasn't been brought up to
date.

John.
