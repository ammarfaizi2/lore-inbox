Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262414AbSKRMjd>; Mon, 18 Nov 2002 07:39:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262418AbSKRMjd>; Mon, 18 Nov 2002 07:39:33 -0500
Received: from 205-158-62-49.outblaze.com ([205.158.62.49]:1804 "HELO
	ws1-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S262414AbSKRMjc>; Mon, 18 Nov 2002 07:39:32 -0500
Message-ID: <20021118124619.52456.qmail@iname.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "L P" <plm@iname.com>
To: linux-kernel@vger.kernel.org
Date: Mon, 18 Nov 2002 20:46:19 +0800
Subject: Problems Hot-Swapping IDE ATA drives
X-Originating-Ip: 212.199.10.23
X-Originating-Server: ws1-1.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
	Please, help me with the following: I have the PCMCIA adapter which converts the ATA compatible PCMCIA cassettes into "True IDE hard disk".
	My RedHat 7.3 linux works fine, when it was booted with the cassette inserted. I can mount/read/write/unmount the device without any error.
	Next, I unmount the device and extract the cassette - usually (not always)I receive the "spurious interrupt" message. Then, when I insert the cassette and try to mount it back, I receive the following errors:
---------
[root@leonp] mount /dev/hdc1 /mnt/pcmcia
end_request: I/O error, dev 16:00 (hdc), sector 2
end_request: I/O error, dev 16:00 (hdc), sector 4
end_request: I/O error, dev 16:00 (hdc), sector 6
end_request: I/O error, dev 16:00 (hdc), sector 0
end_request: I/O error, dev 16:00 (hdc), sector 2
end_request: I/O error, dev 16:00 (hdc), sector 4
end_request: I/O error, dev 16:00 (hdc), sector 6
 unable to read partition table
mount: error while guessing file system type
------------
These messages are repeated several times.

I also tried to issue hdparm -U (or -R) 0 /dev/hdc with exactly the same result.

Any help will be highly appreciated.
Please, post possible answers to my private address, as I am not subscribed to the list.
-- 
__________________________________________________________
Sign-up for your own FREE Personalized E-mail at Mail.com
http://www.mail.com/?sr=signup

