Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262547AbTJOK1k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 06:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262543AbTJOK1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 06:27:39 -0400
Received: from smtp2.att.ne.jp ([165.76.15.138]:56315 "EHLO smtp2.att.ne.jp")
	by vger.kernel.org with ESMTP id S262547AbTJOK0K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 06:26:10 -0400
Message-ID: <00ec01c39306$ac9a3520$3eee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: "Roman Zippel" <zippel@linux-m68k.org>
Cc: "Sam Ravnborg" <sam@ravnborg.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       <linux-kernel@vger.kernel.org>
References: <1f8801c38f11$da95c410$5cee4ca5@DIAMONDLX60> <20031010073750.001ad559.rddunlap@osdl.org> <242001c38fdf$fb165690$5cee4ca5@DIAMONDLX60> <20031011111328.GB932@mars.ravnborg.org> <26ca01c38ff9$f4762d00$5cee4ca5@DIAMONDLX60> <Pine.LNX.4.44.0310131947450.8124-100000@serv>
Subject: Re: 2.6.0-test7 and HIDBP
Date: Wed, 15 Oct 2003 19:23:28 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel replied to me:

> If USB_HIDDEV is set to 'y', then you indeed won't see USB_KBD, as it's
> only selectable if USB_HIDDEV is 'n' or 'm'. It seems to work here.

You are right.  On the machine with Gnome, I ran "make gconfig" again,
changed one of the HID options from "y" to "m", and then the HIDBP options
became available.

Sorry, I didn't guess that changing a setting between "y" and "m" could
affect the visibility of other options this way.  In this case it seems
reasonable, but I still didn't imagine this kind of thing.  Sorry.

