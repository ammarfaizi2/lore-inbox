Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263497AbTLSN10 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 08:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263510AbTLSN10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 08:27:26 -0500
Received: from iron-c-1.tiscali.it ([212.123.84.81]:16267 "EHLO
	mailr-1.tiscali.it") by vger.kernel.org with ESMTP id S263497AbTLSN1Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 08:27:24 -0500
X-BrightmailFiltered: true
Message-ID: <3FE2FC52.3000600@tiscali.it>
Date: Fri, 19 Dec 2003 14:25:38 +0100
From: Michele RECCANELLO <michele.reccanello@tiscali.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; it-IT; rv:1.2.1) Gecko/20030225
X-Accept-Language: it, en, en-us
MIME-Version: 1.0
To: "Chandler, Neville" <chandler@ibiquity.com>,
       "'Samuel Flory'" <sflory@rackable.com>
CC: linux-kernel@vger.kernel.org
Subject: Makefile problem
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux dedalus 2.4.20-8custom #2 lun dic 15 11:17:11 CET 2003 i586 i586
i386 GNU/Linux
 
Gnu C                  3.2.2
Gnu make               3.79.1
util-linux             2.11y
mount                  2.11y
modutils               2.4.22
e2fsprogs              1.32
jfsutils               1.0.17
reiserfsprogs          3.6.4
pcmcia-cs              3.1.31
PPP                    2.4.1
isdn4k-utils           3.1pre4
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 2.0.11
Net-tools              1.60
Kbd                    1.08
Sh-utils               4.5.3
Modules Loaded         mga agpgart 8139too mii ext3 jbd keybdev mousedev
input hid usb-ohci usbcore

I 've got RedHat 9 on K6 550 with 192MB, 40GB Hard disk.
Command "make menuconfig" not set correct link in include directory and
show this messagge:

"/bin/sh: line 1: cd: include: No such file or directory."

I modify Makefile at line 278
before: (cd include; ln -sf asm-$(ARCH) asm)
after: (cd ./include; ln -sf asm-$(ARCH) asm)

It work! There is a problem when make run a cd command, but I don't know why
Thera is similar problem in redhat 8, slackware 9.1 end Mandrake 9.2 and 
when I compiling source code and make exec a cd command.


Ciao e grazie per ogni suggerimento. Merry Xmas.


