Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284187AbRLWPlD>; Sun, 23 Dec 2001 10:41:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283204AbRLWPk4>; Sun, 23 Dec 2001 10:40:56 -0500
Received: from gear.torque.net ([204.138.244.1]:46864 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S281787AbRLWPkm>;
	Sun, 23 Dec 2001 10:40:42 -0500
Message-ID: <3C25FB7C.DA0CF203@torque.net>
Date: Sun, 23 Dec 2001 10:42:52 -0500
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCHes] lk 2.5.2-pre1: sg, advansys + scsi_debug
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some patches to get broken SCSI drivers going
in lk 2.5.2-pre1 :

http://www.torque.net/sg/p/advansys.c252p1min.diff
is a minimal hack to get the advansys adapter driver
going. Hopefully a more solid patch from its
maintainer will follow shortly.

http://www.torque.net/sg/p/sg252p1_2.diff.gz resyncs
the sg driver with lk 2.4.17 and adds some scatterlist
changes required by 2.5 .

http://www.torque.net/sg/p/scsi_debug252p1.diff.gz replaces
the existing scsi_debug "fake" adapter driver with something
that is like a ram disk, that can accept fdisk, mkfs, mount
etc. I have used it in the past to test Richard Gooch's
sd-many patch.

Doug Gilbert
