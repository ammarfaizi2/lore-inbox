Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261294AbVEFWFa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbVEFWFa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 18:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261295AbVEFWFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 18:05:30 -0400
Received: from pih-relay05.plus.net ([212.159.14.132]:10681 "EHLO
	pih-relay05.plus.net") by vger.kernel.org with ESMTP
	id S261294AbVEFWFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 18:05:23 -0400
Message-ID: <004501c55288$3fb762a0$0707a8c0@curly>
Reply-To: "Kevin Crofts" <kevinc@bigbangtv.co.uk>
From: "Kevin Crofts" <kevinc@bigbangtv.co.uk>
To: <linux-kernel@vger.kernel.org>
Subject: No rule to make target 'modules'
Date: Fri, 6 May 2005 23:09:18 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1409
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I'm a complete Newbie to Linux and I am trying to compile a driver and
application on Red Hat 9.0. I have installed Red Hat 9.0 without GUI
and only development tools. I have installed the source code from Disk2
- Kernel-source-2.4.20-8.I386.rpm.
I then ran
make mrproper
I removed 'custom' from the Makefile in /usr/drc/linux-2.4.20-8/Makefile
EXTRAVERSION = -8custom
I then ran
make oldconfig
make dep
make modules && make modules_install
I can see files in /lib/modules/2.3.20-8/build and also I can see Rules.make
in this folder.
When I run Make in the application folder I get the following error:
No rule to make target 'modules'.
Please can some-one help me, I don't understand what I'm doing wrong?
Thanks,
Kevin

