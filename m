Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbTERMzH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 08:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262056AbTERMzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 08:55:07 -0400
Received: from 72.1-182-adsl-pool.axelero.hu ([81.182.1.72]:51472 "EHLO
	server.leva.2y.net") by vger.kernel.org with ESMTP id S262050AbTERMzE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 08:55:04 -0400
Message-ID: <3EC785A6.8070909@ecentrum.hu>
Date: Sun, 18 May 2003 15:07:50 +0200
From: LeVA <leva@ecentrum.hu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: hu, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: usb keyboard problem.
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I have an usb keyboard, and it has some extra keys (internet keys,
multimedia keys).
If I use the keyboard in ps/2 port, all of those extra buttons work,
because I can bind the extra keys's keycodes in a hotkeys program.
If I use the keyboard in the usb port, some of the extra keys don't
work. In plain console, if I push some of the "non-working" extra
buttons, I get these error messages:

    keyboard.c: can't emulate rawmode for keycode 259
    keyboard.c: can't emulate rawmode for keycode 259

The problem is, that I can not bind keycode 259 in X, because it only
works for keycodes between 8 - 255. But when I use the keyboard in the
usb port, I get too high keycodes like (see above) 259, which I can not use.
I (fortunately) have a few working internet buttons. If I press those in
plain console, I get these messages:

    keyboard: unknown scancode e0 66

I don't think this is an error, because that key, which "produces" the
"keyboard: unknown scancode e0 66" message, works under X, and can be
binded to an action.

Is there any chance to make the keyboard work similarly in the ps/2 and
the usb port?

Please try to help me with this problem, I'm already through the
xfree86-list, and the debian-user list, but nobody could help me.

Thanks!

Levai Daniel



