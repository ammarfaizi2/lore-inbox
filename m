Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261884AbTHYNtE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 09:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261904AbTHYNtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 09:49:04 -0400
Received: from smtp1.att.ne.jp ([165.76.15.137]:16772 "EHLO smtp1.att.ne.jp")
	by vger.kernel.org with ESMTP id S261884AbTHYNs7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 09:48:59 -0400
Message-ID: <089b01c36b0f$67d723e0$24ee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: "Russell King" <rmk@arm.linux.org.uk>
Cc: <linux-kernel@vger.kernel.org>
References: <032c01c36a36$2335ea20$24ee4ca5@DIAMONDLX60> <20030824133026.D16635@flint.arm.linux.org.uk>
Subject: Re: Bad serio/atkbd configuration possible (was: Re: Compilation errors in 2.6.0-test4, serial as modules)
Date: Mon, 25 Aug 2003 22:46:17 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Russell King" <rmk@arm.linux.org.uk> replied to me:

> It's not serial, but serio.

The compile errors in 2.6.0-test4 were serio.

The boot-time errors in 2.6.0-test1 through test3, and then in test4 after I
changed the keyboard stuff back from "m" to "y", are that module serial is
not found.  These are not serio, but serial.  As far as I can tell, the
serial stuff other than keyboard and mouse are still modules, so I don't
know what is not being found.  Those messages scroll off the screen very
quickly during boot, and they don't get logged, so I can't report them
exactly.

One other message that I've seen during boot is that boot logging is
disabled because the console doesn't differ from the console.  I don't
exactly understand this one either, but it's sure telling the truth about
disabling boot logging.

