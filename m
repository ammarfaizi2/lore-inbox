Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261645AbTJRPOh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 11:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261649AbTJRPOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 11:14:37 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:62138 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id S261645AbTJRPOg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 11:14:36 -0400
Message-ID: <008c01c39588$9b6f7650$fb457dc0@tgasterix>
Reply-To: "Thomas Giese" <Thomas.Giese@gmx.de>
From: "Thomas Giese" <Thomas.Giese@gmx.de>
To: <linux-kernel@vger.kernel.org>
Subject: 2.6.0-test8-microcode
Date: Sat, 18 Oct 2003 17:00:44 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-Seen: false
X-ID: VTmq0kZfwevCUbL+c0wQbmRmqyjoflvvcVUauIw0h0ZALnxFo6RnZG@t-dialin.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

IA32 microcode fails in compile, in test7 it does not :

linux:/mnt/hdb1/linux-2.6.0-test8 # make
  SPLIT   include/linux/autoconf.h -> include/config/*
make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
  CHK     include/linux/compile.h
  CC [M]  arch/i386/kernel/microcode.o
arch/i386/kernel/microcode.c: In function `find_matching_ucodes':
arch/i386/kernel/microcode.c:328: parse error before `int'
arch/i386/kernel/microcode.c:329: `ext_tablep' undeclared (first use in this
fun
ction)
arch/i386/kernel/microcode.c:329: (Each undeclared identifier is reported
only o
nce
arch/i386/kernel/microcode.c:329: for each function it appears in.)
make[1]: *** [arch/i386/kernel/microcode.o] Error 1
make: *** [arch/i386/kernel] Error 2


