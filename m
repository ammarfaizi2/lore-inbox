Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131633AbRALCvo>; Thu, 11 Jan 2001 21:51:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131630AbRALCve>; Thu, 11 Jan 2001 21:51:34 -0500
Received: from smtp02.mrf.mail.rcn.net ([207.172.4.61]:48869 "EHLO
	smtp02.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S130075AbRALCvX>; Thu, 11 Jan 2001 21:51:23 -0500
Message-ID: <3A5E7126.E28B3F7C@haque.net>
Date: Thu, 11 Jan 2001 21:51:18 -0500
From: "Mohammad A. Haque" <mhaque@haque.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: various issues/questions
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel 2.4.0-prerelease through 2.4.1-pre2

I recently got a Pioneer 105S 16x slot loading DVD drive and have been
getting lots os the following messages when playing dvds and cdroms....

hdb: DSC timeout
hdb: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
hdb: cdrom_decode_status: error=0xb0
hdb: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
hdb: cdrom_decode_status: error=0xb0
hdb: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
hdb: cdrom_decode_status: error=0xb0
hdb: DMA disabled
hdb: ATAPI reset complete
hdb: cdrom_read_intr: data underrun (4 blocks)
end_request: I/O error, dev 03:40 (hdb), sector 1748
hdb: tray open
end_request: I/O error, dev 03:40 (hdb), sector 1748
hdb: tray open
end_request: I/O error, dev 03:40 (hdb), sector 1748
hdb: tray open
end_request: I/O error, dev 03:40 (hdb), sector 1748
hdb: tray open
end_request: I/O error, dev 03:40 (hdb), sector 2448
hdb: tray open
end_request: I/O error, dev 03:40 (hdb), sector 204


Is this possibly specific to slot loading drives? I didn't have problems
with my old Creative 2x dvd drive.



I also saw the following but don;t know what was happening on my machine
at the time.

__alloc_pages: 3-order allocation failed.
__alloc_pages: 3-order allocation failed.
__alloc_pages: 3-order allocation failed.
__alloc_pages: 3-order allocation failed.
__alloc_pages: 3-order allocation failed.
__alloc_pages: 3-order allocation failed.
__alloc_pages: 2-order allocation failed.
__alloc_pages: 2-order allocation failed.
__alloc_pages: 2-order allocation failed.
__alloc_pages: 2-order allocation failed.
__alloc_pages: 2-order allocation failed.
__alloc_pages: 2-order allocation failed.
__alloc_pages: 2-order allocation failed.
__alloc_pages: 2-order allocation failed.
__alloc_pages: 2-order allocation failed.
__alloc_pages: 2-order allocation failed.
__alloc_pages: 2-order allocation failed.
__alloc_pages: 2-order allocation failed.
__alloc_pages: 2-order allocation failed.
__alloc_pages: 2-order allocation failed.
__alloc_pages: 2-order allocation failed.
__alloc_pages: 2-order allocation failed.
__alloc_pages: 2-order allocation failed.
__alloc_pages: 2-order allocation failed.
__alloc_pages: 2-order allocation failed.
__alloc_pages: 3-order allocation failed.


-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/ 
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
