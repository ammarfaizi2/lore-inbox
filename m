Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130882AbQLaU4c>; Sun, 31 Dec 2000 15:56:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130895AbQLaU4X>; Sun, 31 Dec 2000 15:56:23 -0500
Received: from rmx325-mta.mail.com ([165.251.48.53]:53443 "EHLO
	rmx325-mta.mail.com") by vger.kernel.org with ESMTP
	id <S130882AbQLaUzy>; Sun, 31 Dec 2000 15:55:54 -0500
Message-ID: <379744379.978294325610.JavaMail.root@web582-mc>
Date: Sun, 31 Dec 2000 15:25:25 -0500 (EST)
From: Alastair Foster <alasta@mail.com>
To: linux-kernel@vger.kernel.org
Subject: Camera as a USB mass storage / SCSI device
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Mailer: mail.com
X-Originating-IP: 203.96.111.202
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

USB support appears to be coming along nicely. I have just aquired an Agfa
ePhoto digital camera. I have heard several success stories of people who
have compiled kernels with SCSI and USB mass storage support and been able
to emulate their camera's flash memory as a SCSI disk on bootup. Accessing
the camera was then simply a matter of mounting the SCSI device.

Unfortunately, my camera does not get recognised on bootup. This is hardly
surprising, given that the kernel has no way of determining the camera as a
USB mass storage device. However, I'm curious as to how others have managed
to get away with this by doing nothing more than compiling their kernel with
the above options. Is there some sort of database which tells the kernel to
associate a particular USB product ID and vendor with a particular driver?
If so, is there any way to edit this database?


______________________________________________
FREE Personalized Email at Mail.com
Sign up at http://www.mail.com/?sr=signup
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
