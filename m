Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262284AbTFTOPc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 10:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262299AbTFTOPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 10:15:32 -0400
Received: from pop.gmx.net ([213.165.64.20]:15266 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262284AbTFTOP1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 10:15:27 -0400
Message-ID: <004d01c33738$7031e440$0200a8c0@brainbug>
Reply-To: "Thomas Frase" <thomas.frase@ist-einmalig.de>
From: "Thomas Frase" <thomas.frase@herr-der-mails.de>
To: <linux-kernel@vger.kernel.org>
Subject: root shell exploit still working in kernel 2.4.21
Date: Fri, 20 Jun 2003 16:29:59 +0200
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

hello!

the problem:
i tried an exploit (url given below) with debian woody kernel 2.4.18
and self compiled kernel 2.4.21 resulting in a root shell.

exploit code url: (found via google)
http://isec.pl/cliph/isec-ptrace-kmod-exploit.c

as described in the source the exploit uses the well known ptrace bug
which i thought was fixed in kernel 2.4.21.

i don't know why it still works or how to fix it. i told someone people
in #debian.de (quakenet) about the results of the exploit and they
asked me to post a bug report here.

greetings
    thomas f.
    (germany)

Kernel 2.4.21 infos:

Output from ver_linux:
-------------------------------------------------
Linux xXxXx 2.4.21 #1 SMP Fri Jun 20 14:25:09 CEST 2003 i686 unknown

Gnu C                  2.95.4
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
modutils               2.4.21
e2fsprogs              1.27
PPP                    2.4.1
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Procps                 3.1.9
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded
-------------------------------------------------

Output from /proc/version:
-------------------------------------------------
Linux version 2.4.21 (root@xXxXx) (gcc version 2.95.4 20011002 (Debian
prerelease)) #1 SMP Fri Jun 20 14:25:09 CEST 2003
-------------------------------------------------


