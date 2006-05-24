Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932548AbWEXJ17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932548AbWEXJ17 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 05:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932418AbWEXJ17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 05:27:59 -0400
Received: from wildsau.enemy.org ([193.170.194.34]:8091 "EHLO
	wildsau.enemy.org") by vger.kernel.org with ESMTP id S932551AbWEXJ16
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 05:27:58 -0400
From: Herbert Rosmanith <kernel@wildsau.enemy.org>
Message-Id: <200605240922.k4O9MlXW007991@wildsau.enemy.org>
Subject: Q: how to send ATA cmds to USB drive?
To: linux-kernel@vger.kernel.org
Date: Wed, 24 May 2006 11:22:47 +0200 (MET DST)
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


good day,

I have a question concerning sending arbitrary ATA commands to an USB
drive.

Currently, I have a particular application which sends special ATA commands
to an IDE drive using IDE_TASKFILE. So far, this works pretty well.

But now I also have to support USB harddisks from the same company.
The USB harddisk uses the same set of ATA commands as the IDE harddisk,
well, at least that's what I suppose.

How do I send ATA commands to this USB drive? I suppose this would be
done via SG_IO (the drive is recognised by linux as usb-storage, of
course), but how exactly does this have to be done? I have already
used SG_IO before to send some MMC commands to cdvd-drives, but I
don't know how to send ATA (such as those from T13) commands with this
interface.

Do you have any kind of advice?

kind regards,
herbert rosmanith


