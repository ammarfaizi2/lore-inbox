Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271765AbRHRD6O>; Fri, 17 Aug 2001 23:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271767AbRHRD6F>; Fri, 17 Aug 2001 23:58:05 -0400
Received: from mailout5-1.nyroc.rr.com ([24.92.226.169]:61674 "EHLO
	mailout5.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S271765AbRHRD5t>; Fri, 17 Aug 2001 23:57:49 -0400
Message-Id: <200108180358.XAA08108@pb.home>
To: linux-kernel@vger.kernel.org
Subject: strangeness writing CDs (ide and scsi)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8105.998107081.1@pb>
Date: Fri, 17 Aug 2001 23:58:01 -0400
From: "Marty Leisner" <leisner@rochester.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just got an HP9600 cdwriter (scsi, external).

No problem...

I made a CDROM and did a cmp against an ISO master...

then when I tried to read it on an IDE cdrom drive, I get:
hda: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
hda: cdrom_decode_status: error=0x30
hda: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
hda: cdrom_decode_status: error=0x30


I tried 3 different CD-ROM drives on 2 systems (one running redhat 7.1,
the other 6.2).

Same results.

So for grunts, I have a NEC SCSI CD changer...I put the one I wrote
in there...did the cmp...no problem...

(It also would be very, very useful if the error messages would
include the sectors in cdrom_decode_status).

I'm somewhat puzzled...


Marty Leisner
leisner@rochester.rr.com
