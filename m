Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932443AbVLIUSL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932443AbVLIUSL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 15:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbVLIUSL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 15:18:11 -0500
Received: from xproxy.gmail.com ([66.249.82.198]:12637 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932443AbVLIUSK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 15:18:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:from:to:subject:date:mime-version:content-type:content-transfer-encoding:x-priority:x-msmail-priority:x-mailer:disposition-notification-to:x-mimeole;
        b=F8W3nFYTBP9KmtZO/0BHzh/3U0VgGNsldeTxkwQsThPt2qyFn3I6ijUHxiz8q9aqgiKjCYqMGWVIoZJkcIgyG4/rB21Zmdu5pKyj5gv8rCWsE0FECTeqZbTcr2YWeT+4fxesIz/IS3ln7+5FFVG6h0YiSr8eh0ZmI7nHYuF5H5s=
Message-ID: <021301c5fd06$124ceeb0$152116ac@Thiago>
From: "Thiago Moraes" <moraesthiago@gmail.com>
To: <linux-kernel@vger.kernel.org>
Subject: Kernel Error......
Date: Fri, 9 Dec 2005 18:18:14 -0300
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit
X-Priority: 1
X-MSMail-Priority: High
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've trying to compile my kernel on Slackware 10.2, so, when i
select NETWORKING OPTIONS menu is closed, and return to bash....

I saved the showed information and collate here to you...

Can you helpe with this issue ???

Tks,

Thiago Moraes
thiago@igen.epm.br
I.T. - Brazil

=====================================================
root@draco:/usr/src/linux# make menuconfig
rm -f include/asm
( cd include ; ln -sf asm-i386 asm)
make -C scripts/lxdialog all
make[1]: Entering directory `/usr/src/linux-2.4.31/scripts/lxdialog'
make[1]: Leaving directory `/usr/src/linux-2.4.31/scripts/lxdialog'
/bin/sh scripts/Menuconfig arch/i386/config.in
Using defaults found in .config
Preparing scripts: functions, parsing............./MCmenu19: line 149: 
syntax error near unexpected token `fi'
./MCmenu19: line 149: `fi'
......................................................................done.

Menuconfig has encountered a possible error in one of the kernel's
configuration files and is unable to continue.  Here is the error
report:

 Q> scripts/Menuconfig: line 832: MCmenu19: command not found

Please report this to the maintainer <mec@shout.net>.  You may also
send a problem report to <linux-kernel@vger.kernel.org>.

Please indicate the kernel version you are trying to configure and
which menu you were trying to enter when this error occurred.

make: *** [menuconfig] Error 1
===================================================== 
