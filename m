Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318124AbSGWQg4>; Tue, 23 Jul 2002 12:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318123AbSGWQg4>; Tue, 23 Jul 2002 12:36:56 -0400
Received: from chaos.analogic.com ([204.178.40.224]:30081 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S318124AbSGWQgy>; Tue, 23 Jul 2002 12:36:54 -0400
Date: Tue, 23 Jul 2002 12:42:30 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: mmaped Network file
Message-ID: <Pine.LNX.3.95.1020723124022.23780A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To whomever sent mmap.cc, it works as expected on version 2.4.18.

Script started on Tue Jul 23 12:37:27 2002
# df
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/sdb1             16603376   5373644  10386324  34% /
/dev/sdc1              6356624   1198700   4835020  20% /alt
/dev/sdc3              2253284   1768588    370236  83% /home/users
/dev/sda1              1048272    282000    766272  27% /dos/drive_C
/dev/sda5              1046224    181280    864944  17% /dos/drive_D
quark:/tmp              813598    428754    342810  56% /mnt
# pwd
/mnt
# xxx
<Press ENTER to read> OR <Enter string to write> $ test
Written to mapped file: test
<Press ENTER to read> OR <Enter string to write> $ Now is the time for all
Written to mapped file: Now is the time for all
<Press ENTER to read> OR <Enter string to write> $ 
Mapped file contents: Now is the time for all
<Press ENTER to read> OR <Enter string to write> $ 
Mapped file contents: Now is the time for all
<Press ENTER to read> OR <Enter string to write> $ foo
Written to mapped file: foo is the time for all
<Press ENTER to read> OR <Enter string to write> $ 1
Written to mapped file: 1oo is the time for all
<Press ENTER to read> OR <Enter string to write> $ 12
Written to mapped file: 12o is the time for all
<Press ENTER to read> OR <Enter string to write> $ 123
Written to mapped file: 123 is the time for all
<Press ENTER to read> OR <Enter string to write> $ 1234
Written to mapped file: 1234is the time for all
<Press ENTER to read> OR <Enter string to write> $ 12345
Written to mapped file: 12345s the time for all
<Press ENTER to read> OR <Enter string to write> $ 123456
Written to mapped file: 123456 the time for all
<Press ENTER to read> OR <Enter string to write> $ 12345678
Written to mapped file: 12345678he time for all
<Press ENTER to read> OR <Enter string to write> $ 123456789
Written to mapped file: 123456789e time for all
<Press ENTER to read> OR <Enter string to write> $ 123456789a
Written to mapped file: 123456789a time for all
<Press ENTER to read> OR <Enter string to write> $ 
Mapped file contents: 123456789a time for all
<Press ENTER to read> OR <Enter string to write> $ 
Mapped file contents: 123456789a time for all
<Press ENTER to read> OR <Enter string to write> $ 
Mapped file contents: 123456789a time for all
<Press ENTER to read> OR <Enter string to write> $ 
Mapped file contents: 123456789a time for all
<Press ENTER to read> OR <Enter string to write> $ 
# exit
exit

Script done on Tue Jul 23 12:38:39 2002


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

