Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261703AbSJQONv>; Thu, 17 Oct 2002 10:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261727AbSJQONv>; Thu, 17 Oct 2002 10:13:51 -0400
Received: from ext-nj2gw-2.online-age.net ([216.35.73.164]:3783 "EHLO
	ext-nj2gw-2.online-age.net") by vger.kernel.org with ESMTP
	id <S261703AbSJQONu>; Thu, 17 Oct 2002 10:13:50 -0400
Message-ID: <A9713061F01AD411B0F700D0B746CA6802FC1513@vacho6misge.cho.ge.com>
From: "Heater, Daniel (IndSys, GEFanuc, VMIC)" <Daniel.Heater@gefanuc.com>
To: "'Patrick Jennings'" <jennings@red-river.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: RE: Userland ISRs
Date: Thu, 17 Oct 2002 10:19:20 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2655.55)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This all works well and good, execpt when the isr bit is already true when
> isrs are enabled.  Then as soon as they are enabled the isr routine gets
> called, before the sleep has got a chance to get set up.  Any ideas around
> this?

http://www.xml.com/ldd/chapter/book/ch09.html

Read the section about going to sleep without races.
I think you'll find the solution there.
