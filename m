Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263823AbTKFVWj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 16:22:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263830AbTKFVWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 16:22:39 -0500
Received: from mail2-116.ewetel.de ([212.6.122.116]:46062 "EHLO
	mail2.ewetel.de") by vger.kernel.org with ESMTP id S263823AbTKFVWh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 16:22:37 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
In-Reply-To: <OY9D.86A.29@gated-at.bofh.it>
References: <OXZz.7Uj.3@gated-at.bofh.it> <OY9D.86A.29@gated-at.bofh.it>
Date: Thu, 6 Nov 2003 22:22:25 +0100
Message-Id: <E1AHraD-0000Rs-00@neptune.local>
From: Pascal Schmidt <der.eremit@email.de>
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Nov 2003 20:40:37 +0100, you wrote in linux.kernel:

> ide-scsi has always been broken. You should not use it, and indeed there 
> was never any good reason for it existing AT ALL.

So, why is it that my ATAPI MO drive works perfectly with ide-scsi and
sd but not with any of the IDE drivers (even if I hack them to accept
an ATAPI OPTICAL device)?

In 2.6, we have a patch allowing at least read-only use via ide-cd,
but writing still requires ide-scsi. I did the read support part, but
writing eludes me... and the read support is also unlikely to work on
MO discs with a sector size other than 2048 or partitioned ones (I only
use my discs as ext2 superfloppies).

-- 
Ciao,
Pascal
