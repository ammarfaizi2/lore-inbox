Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129659AbQKPFkB>; Thu, 16 Nov 2000 00:40:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129665AbQKPFjv>; Thu, 16 Nov 2000 00:39:51 -0500
Received: from thumper2.emsphone.com ([199.67.51.102]:15374 "EHLO
	thumper2.emsphone.com") by vger.kernel.org with ESMTP
	id <S129659AbQKPFjh>; Thu, 16 Nov 2000 00:39:37 -0500
Date: Wed, 15 Nov 2000 23:09:35 -0600
From: Andrew Ryan <genanr@emsphone.com>
To: linux-kernel@vger.kernel.org
Subject: unexpected busfree problem
Message-ID: <20001115230935.A18780@thumper2.emsphone.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Occasionally I am getting the follow error on my system:

(scsi0:0:0:-1) Unexpected busfree, LASTPHASE = 0x40, SEQADDR = 0x66
Read : (10) 00 4f a0 07 00 00 20 00 
scsi0 channel 0 : resetting for second half of retries.
SCSI bus is being reset for host 0 channel 0.
SCSI host 0 channel 0 reset (pid 0) timer out - trying harder.
SCSI bus is being reset for host 0 channel 0.
SCSI host 0 reset (pid 0) timed out again -
probably an unrecoverable SCSI bus or device hang.
(scsi0:0:0:0) Synchronous at 160.0 Mbytes/sec, offset 63.
Device 804 not ready
 I/O error: dev 08:04, sector 1621936
...etc

I typed in the above since it was not saved in my log file, so it might be
missing some stuff, but nothing that seemed to be needed. 

After that I get a bunch of I/O errors and the system remounts read-only.
Also, after this error has occurred it always happens until I reboot the
system, and sometime I even have to go into the adaptec bios and do nothing
to get it back to working order (I don't change anything in the bios).

I don't think it is the drive, this is the second drive I have tried.  It
might be and controller or cable problem, but it happen so randomly I can't
pin it down.  The adapter is an Adaptec 29160 and I use the internal LVD
cable that came with the card.  My kernel version is 2.4.0-test8. Could this
be a kernel problem?  I've seen it mentioned a couple of time in the past.

Any suggestions?


Andy
 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
