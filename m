Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264991AbTGBNOt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 09:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264993AbTGBNOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 09:14:48 -0400
Received: from scout.wisc.edu ([144.92.170.197]:20911 "EHLO
	hundo.scout.wisc.edu") by vger.kernel.org with ESMTP
	id S264991AbTGBNOs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 09:14:48 -0400
Date: Wed, 2 Jul 2003 08:29:12 -0500 (CDT)
From: Justin Rush <jrush@scout.wisc.edu>
To: linux-kernel@vger.kernel.org
Subject: ide tape drive not working
Message-ID: <Pine.LNX.4.44.0307020825310.3426-100000@hundo.scout.wisc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I am getting a strange error while trying to use my ide-tape drive in 
kernel 2.4.20-18.9.  In dmesg I see that the kernel sees the tape drive: 
hdf: Seagate STT8000A, ATAPI TAPE drive
ide-tape: hdf <-> ht0: Seagate STT8000A rev 5.02
ide-tape: hdf <-> ht0: 600KBps, 14*26kB buffer, 5850kB pipeline, 80ms 
tDSC, DMA
However, when I try and do a mt -f /dev/ht0 status , I get a device or 
resource busy error, and the following gets spit into dmesg:
ide-tape: ht0: I/O error, pc = 34, key =  3, asc = 30, ascq =  0
ide-tape: ht0: I/O error, pc =  1, key =  3, asc = 30, ascq =  0
ide-tape: ht0: I/O error, pc =  0, key =  3, asc = 30, ascq =  0
ide-tape: ht0: drive not ready

What could be the problem here?

Thanks,
Justin

