Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264375AbTLVKqM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 05:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264377AbTLVKqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 05:46:12 -0500
Received: from 82-68-100-158.dsl.in-addr.zen.co.uk ([82.68.100.158]:58336 "EHLO
	cypher") by vger.kernel.org with ESMTP id S264375AbTLVKqL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 05:46:11 -0500
Date: Mon, 22 Dec 2003 10:46:07 +0000 (GMT)
From: David Buckley <DavidBuckley@bigfoot.com>
X-X-Sender: <bucko@cypher.localnet>
To: <linux-kernel@vger.kernel.org>
Subject: Logitech Cordless Desktop MX Buttons not working in 2.6.0.
Message-ID: <Pine.LNX.4.33.0312221023410.23559-100000@cypher.localnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi! I upgraded to Linux 2.6.0 yesterday. After a whole bunch of false
starts, I've got most of my system up and running now, with the
following problem:

I Use a Logitech Wireless Desktop MX keyboard/mouse set, and I've found
that my "Messenger/SMS" and "Shopping" buttons have ceased to work.
showkey in a console tells me nothing about the keys (no output when
these keys are pressed) - all I can get is the following kernel
error/warning messages:

Shopping:
atkbd.c: Unknown key pressed (translated set 2, code 0x12c, data 0x14, on isa0060/serio0).
atkbd.c: Unknown key released (translated set 2, code 0x12c, data 0x94, on isa0060/serio0).

Messenger/SMS:
atkbd.c: Unknown key pressed (translated set 2, code 0x11d, data 0x11, on isa0060/serio0).
atkbd.c: Unknown key released (translated set 2, code 0x11d, data 0x91, on isa0060/serio0).

I wouldn't be too bothered about this if it weren't for the fact that
the keys /also/ don't work in X - X doesn't register the presses, and
looking in dmesg, I see the same errors being output.

I realise that someone's posted to the list about this problem before,
but I found no answer that really explained how to fix it. The one reply
seemed to indicate the use of setkeycodes, but the error message gives
me no real hint about a scancode I can use.

Both keys used to work fine in Linux 2.4.21 - I was using the
Messenger/SMS button to change the DPMS timings on my monitor so I could
have it turn off/on at a buttonpress in X.

I'm running Debian GNU/Linux unstable; the bulk of the system is up to
date as of a week or so ago (but I expect this isn't all that relevant).

-- 
bucko

