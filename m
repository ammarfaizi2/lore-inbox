Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264500AbTFTTY3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 15:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264503AbTFTTY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 15:24:28 -0400
Received: from smtp801.mail.sc5.yahoo.com ([66.163.168.180]:7764 "HELO
	smtp801.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264500AbTFTTYU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 15:24:20 -0400
Reply-To: <benoit.beauchamp@sbcglobal.net>
From: "Benoit Beauchamp" <benoit.beauchamp@sbcglobal.net>
To: <linux-kernel@vger.kernel.org>
Subject: 2.5.72 fixdep / cant make *config
Date: Fri, 20 Jun 2003 12:38:04 -0700
Organization: lightx.org
Message-ID: <000701c33763$7afe1df0$0201a8c0@WIRE>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  HOSTCC  scripts/fixdep
In file included from /usr/include/netinet/in.h:212,
                 from scripts/fixdep.c:107:
/usr/include/bits/socket.h:305:24: asm/socket.h: No such file or directory
scripts/fixdep.c: In function `use_config':
scripts/fixdep.c:193: `PATH_MAX' undeclared (first use in this function)
scripts/fixdep.c:193: (Each undeclared identifier is reported only once
scripts/fixdep.c:193: for each function it appears in.)
scripts/fixdep.c:193: warning: unused variable `s'
scripts/fixdep.c: In function `parse_dep_file':
scripts/fixdep.c:289: `PATH_MAX' undeclared (first use in this function)
scripts/fixdep.c:289: warning: unused variable `s'
make[1]: *** [scripts/fixdep] Error 1
make: *** [scripts] Error 2


For some reason, I cant even make config, make menuconfig or anything like
that. I did find something weird when I tried the 2.4.21 kernel .. Did make
menuconfig and nothing showed up on screen except Load Alternate config and
Save.. 

I think its only a variable that I need to set but I don't know where to
look. Help


