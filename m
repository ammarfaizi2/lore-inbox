Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131337AbQLFC1x>; Tue, 5 Dec 2000 21:27:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131338AbQLFC1n>; Tue, 5 Dec 2000 21:27:43 -0500
Received: from uberbox.mesatop.com ([208.164.122.11]:33542 "EHLO
	uberbox.mesatop.com") by vger.kernel.org with ESMTP
	id <S131337AbQLFC1d>; Tue, 5 Dec 2000 21:27:33 -0500
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation/Changes reminder to upgrade modutils.
Date: Tue, 5 Dec 2000 18:57:15 -0700
X-Mailer: KMail [version 1.1.95.2]
Content-Type: text/plain
MIME-Version: 1.0
Message-Id: <00120518571500.20053@localhost.localdomain>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff V. Merkey wrote:
>Mohammad A. Haque wrote:
>> Are you using the latest version of modutils?
>>
>> Delaporte Frédéric wrote:
>> >
>> > Hello.
>> >
>> > make modules_install seems to do a wrong call to depmod, using an unknow
>> > option "-F".
>
>Upgrade your modutils.
>

The following patch may seem ridiculous, but now people
can be told the more generic: Please read Documentation/Changes.

diff -u linux/Documentation/Changes.orig linux/Documentation/Changes
--- linux/Documentation/Changes.orig    Tue Dec  5 18:37:32 2000
+++ linux/Documentation/Changes Tue Dec  5 18:38:53 2000
@@ -31,7 +31,7 @@
 Eine deutsche Version dieser Datei finden Sie unter
 <http://www.stefan-winter.de/Changes-2.4.0.txt>.
 
-Last updated: October 25, 2000
+Last updated: December 5, 2000
 
 Chris Ricker (kaboom@gatech.edu or chris.ricker@genetics.utah.edu).
 
@@ -52,7 +52,7 @@
 o  Gnu make               3.77                    # make --version
 o  binutils               2.9.1.0.25              # ld -v
 o  util-linux             2.10o                   # kbdrate -v
-o  modutils               2.3.18                  # insmod -V
+o  modutils               2.3.21                  # insmod -V
 o  e2fsprogs              1.19                    # tune2fs --version
 o  pcmcia-cs              3.1.21                  # cardmgr -V
 o  PPP                    2.4.0                   # pppd --version
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
