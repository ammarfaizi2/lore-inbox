Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132372AbRCaLm0>; Sat, 31 Mar 2001 06:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132373AbRCaLmR>; Sat, 31 Mar 2001 06:42:17 -0500
Received: from smtp014.mail.yahoo.com ([216.136.173.58]:55570 "HELO
	smtp014.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S132372AbRCaLmH>; Sat, 31 Mar 2001 06:42:07 -0500
X-Apparently-From: <nietzel@yahoo.com>
Message-ID: <003001c0ba23$217f81c0$1401a8c0@nietzel>
Reply-To: "Earle Nietzel" <nietzel@yahoo.com>
From: "Earle Nietzel" <nietzel@yahoo.com>
To: <linux-kernel@vger.kernel.org>
Subject: Minor 2.4.3 Adaptec Driver Problems
Date: Sat, 31 Mar 2001 12:42:38 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just got 2.4.3 up a running (on Abit BP6 Dual Celeron ) and
it reorderd my SCSI id's. Take a look. I don't like that my ZIP drive
becomes sda because if I ever remove it then I'll @#$% my harddrive dev
mappings again and have to change them again. Adaptec Driver 6.1.5
:-(

<2.4.3
Detected scsi disk sda at scsi0, channel 0, id 6, lun 0
Detected scsi disk sdb at scsi0, channel 0, id 10, lun 0
Detected scsi removable disk sdc at scsi1, channel 0, id 0, lun 0
Detected scsi CD-ROM sr0 at scsi1, channel 0, id 1, lun 0
Detected scsi CD-ROM sr1 at scsi1, channel 0, id 2, lun 0

>2.4.3
Detected scsi removable disk sda at scsi0, channel 0, id 0, lun 0
Detected scsi CD-ROM sr0 at scsi0, channel 0, id 1, lun 0
Detected scsi CD-ROM sr1 at scsi0, channel 0, id 2, lun 0
Detected scsi disk sdb at scsi1, channel 0, id 6, lun 0
Detected scsi disk sdc at scsi1, channel 0, id 10, lun 0

I am not a participant on this mail list so please mail replies directly to
me.

Earle


_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

