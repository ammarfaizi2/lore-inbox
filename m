Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261582AbSKTQ75>; Wed, 20 Nov 2002 11:59:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261593AbSKTQ75>; Wed, 20 Nov 2002 11:59:57 -0500
Received: from mail2.broadpark.no ([217.13.4.9]:18379 "HELO mail.broadpark.no")
	by vger.kernel.org with SMTP id <S261582AbSKTQ7z>;
	Wed, 20 Nov 2002 11:59:55 -0500
Message-ID: <3DDBC122.9B69230@broadpark.no>
Date: Wed, 20 Nov 2002 18:06:42 +0100
From: Helge Hafting <helge.hafting@broadpark.no>
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.5.47 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.48-bk2 and -mm1 can't mount root?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is this a known problem of some sort?
I have tried 2.5.48-bk2 on one
machine, and 2.5.48-mm1 on two.

The result is always the same:
disks and partitions are detected, but the
root mount fails with a panic message that
it couldn't mount root on major:minor.

The major:minor numbers are correct,
a ide drive for the first machine and a
scsi raid-1 device on the other.

Both machines runs 2.5.47 with no other
problems than ALSA silence.

I use gcc 2.95.4 (debian) on both machines,
and both uses devfs & preempt. One is
UP and the other SMP

Helge Hafting
