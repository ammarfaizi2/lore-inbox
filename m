Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264088AbTFHAXe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 20:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264091AbTFHAXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 20:23:34 -0400
Received: from landfill.ihatent.com ([217.13.24.22]:29112 "EHLO
	pileup.ihatent.com") by vger.kernel.org with ESMTP id S264088AbTFHAXd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 20:23:33 -0400
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.70-mm6
References: <20030607151440.6982d8c6.akpm@digeo.com>
From: Alexander Hoogerhuis <alexh@ihatent.com>
Date: 08 Jun 2003 02:37:07 +0200
In-Reply-To: <20030607151440.6982d8c6.akpm@digeo.com>
Message-ID: <873cilz9os.fsf@lapper.ihatent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@digeo.com> writes:
>
> [SNIP]
>

It builds nicely here and runs nicely so far, but my USB-drive still
blows up after a few gigs and I have this one when plugging it in:

Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
spurious 8259A interrupt: IRQ7.
SCSI device sda: 490232832 512-byte hdwr sectors (250999 MB)
sda: cache data unavailable
sda: assuming drive cache: write through
 /dev/scsi/host0/bus0/target0/lun0: p1
devfs_mk_dir(scsi/host0/bus0/target0/lun0): could not append to dir: ea549820 "target0"
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on sda1, internal journal
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.

mvh,
A
-- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy
