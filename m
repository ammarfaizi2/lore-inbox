Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263510AbUA0HRG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 02:17:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263606AbUA0HRG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 02:17:06 -0500
Received: from smtp10.hy.skanova.net ([195.67.199.143]:9197 "EHLO
	smtp10.hy.skanova.net") by vger.kernel.org with ESMTP
	id S263510AbUA0HRB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 02:17:01 -0500
Date: Tue, 27 Jan 2004 08:16:59 +0100 (CET)
Message-Id: <200401270716.i0R7Gxw21819@d1o408.telia.com>
From: "Voluspa" <lista3@comhem.se>
Reply-To: "Voluspa" <lista3@comhem.se>
To: linux-kernel@vger.kernel.org
Subject: Re: atkbd.c: Unknown key released
X-Mailer: Telia Webmail
X-Telia-webmail-clientstamp: [217.208.132.234] 2004-01-27 08:16:59
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004-01-27 it was written:

> > I keep getting the following in my syslog whenever I startx:

In fact, it is preemptively written even _before_ I start X :-)
I'm using an ancient IBM PS2 swedish keyboard, and this 0x7a crap began
showing somewhere at 2.6.1 (then without blaming X). Now it is - and the
blame on X came with 2.6.2-rc2:

Booting:

Jan 26 16:29:10 loke kernel: atkbd.c: Unknown key released (translated
set 2, code 0x7a on isa0060/serio0).
Jan 26 16:29:10 loke kernel: atkbd.c: This is an XFree86 bug. It
shouldn't access hardware directly.
Jan 26 16:29:11 loke kernel: atkbd.c: Unknown key released (translated
set 2, code 0x7a on isa0060/serio0).
Jan 26 16:29:11 loke kernel: atkbd.c: This is an XFree86 bug. It
shouldn't access hardware directly.

Starting X:

Jan 26 16:33:50 loke kernel: atkbd.c: Unknown key released (translated
set 2, code 0x7a on isa0060/serio0).
Jan 26 16:33:50 loke kernel: atkbd.c: This is an XFree86 bug. It
shouldn't access hardware directly.
Jan 26 16:33:50 loke kernel: atkbd.c: Unknown key released (translated
set 2, code 0x7a on isa0060/serio0).
Jan 26 16:33:50 loke kernel: atkbd.c: This is an XFree86 bug. It
shouldn't access hardware directly.

Mvh
Mats Johannesson


