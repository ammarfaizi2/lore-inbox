Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261297AbSJQKMi>; Thu, 17 Oct 2002 06:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261300AbSJQKMi>; Thu, 17 Oct 2002 06:12:38 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:28430 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S261297AbSJQKMh>; Thu, 17 Oct 2002 06:12:37 -0400
Message-ID: <3DAE8E90.D3E7CACF@aitel.hist.no>
Date: Thu, 17 Oct 2002 12:18:56 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.5.42 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: neilb@cse.unsw.edu.au, groudier@free.fr, axboe@suse.de
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>
Subject: Re: 2.5.43 smp bootup crash, more info - probably scsi/raid
References: <3DAE605F.3B744FFC@broadpark.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:

> It produced a backtrace so long that most of it
> scrolled off the screen, before stating that
> it didn't sync in an interrupt handler.
>
Some of the functions in the trace was scsi stuff.
I have a tekram scsi controller, driven by
"SYM53C8XX Version 2 SCSI support"

The crash happens immediately after initializing
the controller and discovering the two
disks.  This is where autodetection
of RAID usually happens.
So it seems to me that it is either some
scsi problem, or a RAID problem.

The problem affects both 2.5.43 and 2.5.43-mm2.

Helge Hafting
