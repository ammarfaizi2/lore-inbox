Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <157328-27300>; Sat, 30 Jan 1999 19:22:29 -0500
Received: by vger.rutgers.edu id <157232-27300>; Sat, 30 Jan 1999 19:22:09 -0500
Received: from knox3-dial-50.vic.com ([208.150.219.50]:62875 "EHLO rd.novaone.dynip.com" ident: "zoot") by vger.rutgers.edu with ESMTP id <157166-27300>; Sat, 30 Jan 1999 19:22:03 -0500
Message-ID: <XFMail.990130193525.rdicaire@vic.com>
X-Mailer: XFMail 1.1 [p0] on Linux
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Date: Sat, 30 Jan 1999 19:17:03 -0500 (EST)
From: rdicaire@vic.com
To: Kernel Mailing List <linux-kernel@vger.rutgers.edu>
Subject: DES encryption in loop device (kernel 2.2.1)
Sender: owner-linux-kernel@vger.rutgers.edu

In trying to DES encrypt a loop mounted ext2 file system, I get the
following errors:

losetup -e des /dev/loop4 MYFILE3
Password: xxxxxxxxxxxxxxx
Init (up to 16 hex digits): xxxxxxxxxxxxx
ioctl: LOOP_SET_STATUS: Invalid argument

Using XOR works but we all know XOR isn't secure. Is there a patch to fix this?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
