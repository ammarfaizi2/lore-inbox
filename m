Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262592AbTKVSNT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 13:13:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262601AbTKVSNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 13:13:18 -0500
Received: from sea1-dav23.sea1.hotmail.com ([207.68.162.80]:57092 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S262592AbTKVSNR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 13:13:17 -0500
X-Originating-IP: [216.75.183.140]
X-Originating-Email: [xaphod_at_work@hotmail.com]
From: "Tim Carr" <xaphod_at_work@hotmail.com>
To: <linux-kernel@vger.kernel.org>
Subject: IDE LED and 2.4.22, weird problem
Date: Sat, 22 Nov 2003 13:14:13 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Message-ID: <Sea1-DAV23ZvIPNTAbA00001260@hotmail.com>
X-OriginalArrivalTime: 22 Nov 2003 18:13:16.0861 (UTC) FILETIME=[4D32A6D0:01C3B124]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey there,

I have a very weird thing happening with my Linux router.  I upgraded the
kernel from 2.4.21 to 2.4.22, with almost no configuration changes. Now,
when the machine has been powered on for awhile (about 2 or 3 hours), the
IDE LED will just stay on permanently.  I figured some process was thrashing
or just doing tons of swapping, but using iostat reveals that there's
absolutely no I/O (there's a little every now and then, but not as much as a
solid light on all the time); it makes no difference if I kill off every
single process possible (except kernel and init).  The LED will stay lit
permanently (3 days never went off).  Rebooting the machine fixes the
problem for another 2 or 3 hours until it occurs again.  Reverting back to
kernel 2.4.21 fixes the problem entirely! Right now i've reverted to 2.4.21
as it's annoying not having an IDE LED that "works".

Why would my IDE LED get stuck "on"? I'm not using any non-standard IDE
drivers, just the Uniform IDE driver etc.

Please cc all replies to my email address also.

Thanks,

Tim Carr
