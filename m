Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265750AbUAKEF7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 23:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265751AbUAKEF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 23:05:59 -0500
Received: from hera.cwi.nl ([192.16.191.8]:2724 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S265750AbUAKEF5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 23:05:57 -0500
From: Andries.Brouwer@cwi.nl
Date: Sun, 11 Jan 2004 05:05:52 +0100 (MET)
Message-Id: <UTC200401110405.i0B45q016858.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, sven.kissner@consistencies.net
Subject: Re: logitech cordless desktop deluxe optical keyboard issues
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    > Anyway, I released kbd-1.10 last week or so, and it ignores the
    > kernel NR_KEYS but tries to adapt dynamically to the kernel.
    > It would not come with this error message, I suppose.

    the message doesn't appear anymore, but installing is giving me
    the following:

    <-- snip -->
    Setting up kbd (1.10-1) ...
    Looking for keymap to install:
    de-latin1-nodeadkeys
    cannot open file de-latin1-nodeadkeys
    Loading /etc/console/boottime.kmap.gz
    <-- snap -->

I suppose by default you would find these under

/usr/share/kbd/keymaps/i386/qwertz/de-latin1-nodeadkeys.map.gz
/usr/share/kbd/keymaps/mac/all/mac-de-latin1-nodeadkeys.map.gz

    > : atkbd.c: Unknown key pressed (translated set 2, code 0x91 on
    >
    > This is something different, a key without associated keycode.
    > That is normal. If it really has high bit set it is a bit unusual.
    > (What does showkey -s show?)

    showkey -s is giving me exactly the same:
    <-- snip -->
    atkbd.c: Unknown key pressed
    <-- snap -->

That is a kernel message, not showkey output.
(BTW - which kernel precisely? The message is not the 2.6.0 one.)
Maybe showkey -s never sees them?

Andries
