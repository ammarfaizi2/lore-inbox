Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262694AbTKEHrx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 02:47:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262714AbTKEHrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 02:47:53 -0500
Received: from [213.250.81.174] ([213.250.81.174]:20426 "EHLO
	blueberrysolutions.com") by vger.kernel.org with ESMTP
	id S262694AbTKEHrt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 02:47:49 -0500
Date: Wed, 5 Nov 2003 09:47:47 +0200 (EET)
From: Tony Glader <Tony.Glader@blueberrysolutions.com>
X-X-Sender: teg@blueberrysolutions.com
To: linux-kernel@vger.kernel.org
Subject: 2.4.22 and Sony DVD DRU-510
Message-ID: <Pine.LNX.4.44.0311050923150.32038-100000@blueberrysolutions.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Should 2.4.22 support Sony DVD RW DRU-510A? I can't use it with my nForce2 
motherboard (Abit NF7S). I'm using it with ide-scsi. When trying to read 
data from it, I just get about 1,5Mb  and then following error messages:

# dd if=/dev/scd0 of=test.img
dd: reading `/dev/scd0': Input/output error
2960+0 records in
2960+0 records out

# du test.img
1484    test.img

# dmesg


....cut...
SCSI cdrom error : host 0 channel 0 id 0 lun 0 return code = 28000000
Info fld=0x323, ILI Current sd0b:00: sense key Illegal Request
Additional sense indicates Illegal mode for this track
 I/O error: dev 0b:00, sector 3164
SCSI cdrom error : host 0 channel 0 id 0 lun 0 return code = 28000000
Info fld=0x323, ILI Current sd0b:00: sense key Illegal Request
Additional sense indicates Illegal mode for this track
 I/O error: dev 0b:00, sector 3168
SCSI cdrom error : host 0 channel 0 id 0 lun 0 return code = 28000000
Info fld=0x323, ILI Current sd0b:00: sense key Illegal Request
Additional sense indicates Illegal mode for this track
 I/O error: dev 0b:00, sector 3172
SCSI cdrom error : host 0 channel 0 id 0 lun 0 return code = 28000000
Info fld=0x323, ILI Current sd0b:00: sense key Illegal Request
Additional sense indicates Illegal mode for this track
 I/O error: dev 0b:00, sector 3176
SCSI cdrom error : host 0 channel 0 id 0 lun 0 return code = 28000000
Info fld=0x323, ILI Current sd0b:00: sense key Illegal Request
Additional sense indicates Illegal mode for this track
 I/O error: dev 0b:00, sector 3180
SCSI cdrom error : host 0 channel 0 id 0 lun 0 return code = 28000000
Info fld=0x323, ILI Current sd0b:00: sense key Illegal Request
Additional sense indicates Illegal mode for this track
 I/O error: dev 0b:00, sector 3184
SCSI cdrom error : host 0 channel 0 id 0 lun 0 return code = 28000000
Info fld=0x323, ILI Current sd0b:00: sense key Illegal Request
Additional sense indicates Illegal mode for this track
 I/O error: dev 0b:00, sector 3188
SCSI cdrom error : host 0 channel 0 id 0 lun 0 return code = 28000000
Info fld=0x323, ILI Current sd0b:00: sense key Illegal Request
Additional sense indicates Illegal mode for this track
 I/O error: dev 0b:00, sector 3192
SCSI cdrom error : host 0 channel 0 id 0 lun 0 return code = 28000000
Info fld=0x323, ILI Current sd0b:00: sense key Illegal Request
Additional sense indicates Illegal mode for this track
 I/O error: dev 0b:00, sector 3196
SCSI cdrom error : host 0 channel 0 id 0 lun 0 return code = 28000000
Info fld=0x323, ILI Current sd0b:00: sense key Illegal Request
Additional sense indicates Illegal mode for this track
 I/O error: dev 0b:00, sector 3200
SCSI cdrom error : host 0 channel 0 id 0 lun 0 return code = 28000000
Info fld=0x323, ILI Current sd0b:00: sense key Illegal Request
Additional sense indicates Illegal mode for this track
 I/O error: dev 0b:00, sector 3204
SCSI cdrom error : host 0 channel 0 id 0 lun 0 return code = 28000000
Info fld=0x323, ILI Current sd0b:00: sense key Illegal Request
Additional sense indicates Illegal mode for this track
 I/O error: dev 0b:00, sector 3208
 I/O error: dev 0b:00, sector 3212


-- 
* Tony Glader 

