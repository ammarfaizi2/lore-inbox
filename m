Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271235AbTG2Cid (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 22:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271236AbTG2Cid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 22:38:33 -0400
Received: from inova102.correio.tnext.com.br ([200.222.67.102]:33726 "HELO
	trinity-auth.correio.tnext.com.br") by vger.kernel.org with SMTP
	id S271235AbTG2Ci0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 22:38:26 -0400
X-Analyze: Velop Mail Shield v0.0.3
Date: Mon, 28 Jul 2003 23:38:23 -0300 (BRT)
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_L=2E_W=2E_Meunier?= <0@pervalidus.tk>
X-X-Sender: fredlwm@pervalidus.dyndns.org
To: linux-kernel@vger.kernel.org
Subject: Re: PS/2 mouse and 2.6.0-test2
Message-ID: <Pine.LNX.4.56.0307282323430.193@pervalidus.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> When I move it (I don't even press a button) it moves very
> fast and may even execute the first -S command, what would
> require pressing both buttons 3 times followed by the left.
> The same if I killall gpm and use the mouse in XFree86. Then
> it starts rxvt etc.

I forgot to add the following from the logs, from my 3 boots.
Such messages don't appear in XFree86 (also nothing in
XFree86.0.log), where the mouse also fails:

Jul 28 19:15:09 pervalidus kernel: psmouse.c: Lost synchronization, throwing 1  bytes away.

Jul 28 19:21:33 pervalidus kernel: psmouse.c: Lost synchronization, throwing 1  bytes away.
Jul 28 19:21:42 pervalidus kernel: psmouse.c: Lost synchronization, throwing 2  bytes away.
Jul 28 19:21:43 pervalidus last message repeated 2 times

Jul 28 19:45:13 pervalidus kernel: psmouse.c: Lost synchronization, throwing 1  bytes away.
Jul 28 19:46:17 pervalidus kernel: psmouse.c: Lost synchronization, throwing 2  bytes away.
Jul 28 19:46:18 pervalidus kernel: psmouse.c: Lost synchronization, throwing 2  bytes away.
Jul 28 19:46:19 pervalidus kernel: psmouse.c: Lost synchronization, throwing 1  bytes away.
Jul 28 19:46:22 pervalidus kernel: psmouse.c: Lost synchronization, throwing 2  bytes away.
Jul 28 19:46:30 pervalidus kernel: psmouse.c: Lost synchronization, throwing 2  bytes away.
Jul 28 19:46:35 pervalidus kernel: psmouse.c: Lost synchronization, throwing 1  bytes away.
Jul 28 19:46:37 pervalidus kernel: psmouse.c: Lost synchronization, throwing 1  bytes away.
Jul 28 19:46:37 pervalidus kernel: psmouse.c: Lost synchronization, throwing 2  bytes away.
Jul 28 19:46:40 pervalidus kernel: psmouse.c: Lost synchronization, throwing 1  bytes away.
Jul 28 19:46:41 pervalidus kernel: psmouse.c: Lost synchronization, throwing 1  bytes away.

I read someone got it to work as a module, so I'll likely try
that tomorrow.
