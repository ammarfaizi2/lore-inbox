Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276523AbRI2PeB>; Sat, 29 Sep 2001 11:34:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276524AbRI2Pdv>; Sat, 29 Sep 2001 11:33:51 -0400
Received: from mi1-90.dialup.tiscalinet.it ([62.11.51.90]:2820 "EHLO
	Linux.tiscalinet.it") by vger.kernel.org with ESMTP
	id <S276523AbRI2Pdp>; Sat, 29 Sep 2001 11:33:45 -0400
Date: Fri, 28 Sep 2001 15:18:06 +0200
Message-Id: <200109281318.f8SDI6r01123@Linux.tiscalinet.it>
From: bescir@hotmail.com
Subject: error using dd with Linux 2.4.10 
To: linux-kernel@vger.kernel.org
X-Originating-IP: 127.0.0.1
X-Mailer: Webmin 0.87
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="--------1001683086"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
----------1001683086
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

For your info:
this  happens on my PC when trying a "dd" on my SCSI CD (Pioneer CD-ROM
changer DRM-6324X) connected to the sym53c895 SCSI controller after the
"upgrade" to kernel version 2.4.10 from 2.4.9. Note that with 2.4.9
everything went O.K.
 
root@anaconda:~# dd if=/dev/scd6 of=/dev/null
dd: /dev/scd6: Input/output error
400+0 records in
400+0 records out
 
root@anaconda:~# tail  /var/log/syslog
Sep 28 18:10:47 anaconda kernel:  I/O error: dev 0b:06, sector 400
Sep 28 18:10:47 anaconda kernel: scsi0 channel 0 : resetting for second
half of
retries.
Sep 28 18:10:47 anaconda kernel: SCSI bus is being reset for host 0
channel 0.
Sep 28 18:10:47 anaconda kernel: sym53c8xx_reset: pid=0 reset_flags=1
serial_num
ber=0 serial_number_at_timeout=0
Sep 28 18:10:47 anaconda kernel: scsi0: device driver called scsi_done()
for a s
ynchronous reset.
Sep 28 18:10:47 anaconda kernel: sym53c895-0: Downloading SCSI SCRIPTS.
Sep 28 18:10:47 anaconda kernel: sym53c895-0: SCSI bus mode change from
80 to 80
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
----------1001683086--
