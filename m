Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262318AbTEAEtK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 00:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbTEAEtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 00:49:10 -0400
Received: from dsl-140-114.aei.ca ([66.36.140.114]:5124 "HELO elbasta.ath.cx")
	by vger.kernel.org with SMTP id S262318AbTEAEtJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 00:49:09 -0400
Message-ID: <00b701c30f9e$772ec8b0$8000a8c0@ELBASTA>
From: "Frederic Trudeau" <ftrudeau@zesolution.com>
To: <linux-kernel@vger.kernel.org>
Subject: Fatal: Kernel /boot/vmlinux-2.4.18-27.7.xsmp is too big
Date: Thu, 1 May 2003 00:59:37 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings.

I am really not sure if I post this problem to the right list, but here it
is ...
I've got RH 7.3 running on a i686 SMP machine. I downloaded and
installed RedHat's kernel-smp-2.4.18-3 RPM, reconfigured lilo, rebooted,
bingo.

Now im having problems with the kernel-smp-2.4.18-27.7.x RPM.

When trying to run lilo, I get the error message, that I pasted in the
subject line
Now, the error message is pretty obvious, but I still dont get why lilo (or
anything
else) wouls give me this error message, since this is a RPM that was build
for
my exact system architecture, and my exact OS.

Here is the content of my /boot directory :

-rw-r--r--    1 root     root          512 Apr 29 19:17 boot.0800
-rw-r--r--    1 root     root         5824 Jun 24  2001 boot.b
-rw-r--r--    1 root     root          612 Jun 24  2001 chain.b
-rw-r--r--    1 root     root        42255 Mar 14 06:24
config-2.4.18-27.7.xsmp
-rw-r--r--    1 root     root        39947 Apr 18  2002 config-2.4.18-3
-rw-r--r--    1 root     root        39945 Apr 18  2002 config-2.4.18-3smp
drwxr-xr-x    2 root     root         1024 Apr 30 08:58 grub
-rw-r--r--    1 root     root       267061 Apr 30 08:58
initrd-2.4.18-27.7.xsmp.img
-rw-r--r--    1 root     root       261683 Apr 29 19:08 initrd-2.4.18-3.img
-rw-r--r--    1 root     root       268599 Apr 29 19:07
initrd-2.4.18-3smp.img
-rw-r--r--    1 root     root          477 Apr 29 19:22 kernel.h
drwx------    2 root     root        12288 Apr 29 19:02 lost+found
-rw-------    1 root     root        32768 Apr 29 20:11 map
-rw-r--r--    1 root     root        23108 Jun 24  2001 message
lrwxrwxrwx    1 root     root           20 Apr 29 19:08 module-info ->
module-info-2.4.18-3
-rw-r--r--    1 root     root        15436 Mar 14 06:24
module-info-2.4.18-27.7.xsmp
-rw-r--r--    1 root     root        14431 Apr 18  2002 module-info-2.4.18-3
-rw-r--r--    1 root     root        14431 Apr 18  2002
module-info-2.4.18-3smp
-rw-r--r--    1 root     root          640 Jun 24  2001 os2_d.b
lrwxrwxrwx    1 root     root           22 Apr 29 19:22 System.map ->
System.map-2.4.18-3smp
-rw-r--r--    1 root     root       518438 Mar 14 06:24
System.map-2.4.18-27.7.xsmp
-rw-r--r--    1 root     root       465966 Apr 18  2002 System.map-2.4.18-3
-rw-r--r--    1 root     root       490685 Apr 18  2002
System.map-2.4.18-3smp
-rwxr-xr-x    1 root     root      3463389 Mar 14 06:24
vmlinux-2.4.18-27.7.xsmp
-rwxr-xr-x    1 root     root      2835238 Apr 18  2002 vmlinux-2.4.18-3
-rwxr-xr-x    1 root     root      3176626 Apr 18  2002 vmlinux-2.4.18-3smp
lrwxrwxrwx    1 root     root           16 Apr 29 19:08 vmlinuz ->
vmlinuz-2.4.18-3
-rw-r--r--    1 root     root      1155108 Mar 14 06:24
vmlinuz-2.4.18-27.7.xsmp
-rw-r--r--    1 root     root      1030147 Apr 18  2002 vmlinuz-2.4.18-3
-rw-r--r--    1 root     root      1108097 Apr 18  2002 vmlinuz-2.4.18-3smp

Any pointers appreciated.


