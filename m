Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265077AbTBBAiB>; Sat, 1 Feb 2003 19:38:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265081AbTBBAiB>; Sat, 1 Feb 2003 19:38:01 -0500
Received: from smtp01.mrf.mail.rcn.net ([207.172.4.60]:913 "EHLO
	smtp01.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S265077AbTBBAh7>; Sat, 1 Feb 2003 19:37:59 -0500
Message-ID: <3E3C6AA1.7060905@cs.bc.edu>
Date: Sat, 01 Feb 2003 19:47:29 -0500
From: Amitabha Roy <aroy@cs.bc.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: CDROM ATAPI errors (DriveReady SeekComplete DataRequest errors)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

I am getting the following errors on linux kernels 2.4.18-19.8.0 (Redhat 
8 production kernel)
and kernel 2.4.21-pre3 and 2.5.59. 
Feb  1 19:15:32 localhost kernel: hdc: ATAPI reset complete
Feb  1 19:33:29 localhost kernel: hdc: status error: status=0x58 { 
DriveReady SeekComplete DataRequest }
Feb  1 19:33:29 localhost kernel: hdc: drive not ready for command
Feb  1 19:33:31 localhost kernel: hdc: status error: status=0x58 { 
DriveReady SeekComplete DataRequest }
Feb  1 19:33:31 localhost kernel: hdc: drive not ready for command


Every few minutes this error is written into the log and my system 
freezes up for about 1 minute.
Killing magicdev stops the problem from happening. If I mount a CDROM, 
the error repeats.

I have used hdparm to disable DMA on my drive - no change.

The drive is a SONY CDRW - it is set as the master on a cable (its slave 
is a Toshiba DVDROM).  My hard drive is on a separate cable.

Can someone please help ?

Amitabha





