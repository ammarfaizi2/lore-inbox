Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262462AbTCIHld>; Sun, 9 Mar 2003 02:41:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262470AbTCIHld>; Sun, 9 Mar 2003 02:41:33 -0500
Received: from h-64-105-35-18.SNVACAID.covad.net ([64.105.35.18]:46208 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S262462AbTCIHlc>; Sun, 9 Mar 2003 02:41:32 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sat, 8 Mar 2003 23:51:52 -0800
Message-Id: <200303090751.XAA01395@adam.yggdrasil.com>
To: akpm@digeo.com
Subject: Re: 2.5.64bk3 no screen after Ok booting kernel
Cc: jason@jeetkunedomaster.net, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
>Did you try adding "console=tty0" to the boot command?  That got broken too.

	Thank you!  That was the problem.

	The machine that originally worked had
"console=ttyS0,38400 console=tty0" so that its kernel messages
can be logged to a serial port.  The machine that did not work
did not have any "console=" boot argument.  Adding "console=tty0"
restored console behavior.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
