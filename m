Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263832AbTLaLea (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 06:34:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263851AbTLaLea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 06:34:30 -0500
Received: from balu1.urz.unibas.ch ([131.152.1.51]:41436 "EHLO
	balu1.urz.unibas.ch") by vger.kernel.org with ESMTP id S263832AbTLaLe2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 06:34:28 -0500
Message-ID: <1072870466.3ff2b442d2d23@webmail.unibas.ch>
Date: Wed, 31 Dec 2003 12:34:26 +0100
From: Curzio.Basso@unibas.ch
To: linux-kernel@vger.kernel.org
Subject: [drm:radeon_lock_take]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
X-Originating-IP: 80.139.96.44
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all!

I've got a mysterious (for me) bug(?):

whenever I run a program using an OpenGL context, as soon as I do some windowing
operation (say, minimize the window of the program or switching focus etc.), the
system sort of freeze. To be precise: the desktop freezes partially, but I can
still move the mouse, halt the machine via power button, or ssh to the machine
and kill the app. After unfreezing the desktop, in the messages log there is the
following line:

kernel: [drm:radeon_lock_take] *ERROR* 4 holds heavyweight lock

Another quite annoying thing is that this behaviour is not so easily
reproducible, that is: not everytime the windowing system intervenes the desktop
freezes...

The machine is a Compaq Presario 2700 laptop, with a PIII, running 2.6.0. The
graphic card is a radeon mobility M6 LY, which, if I am not mistaken, belongs to
the radeon 7000 family...

Needless to say, I did not find anything on this mailist, although there were
other messages on FreeBSD and Debian mailing lists which described a problem
which basically looked the same.

If anyone has a good advice, it would be highly appreciated. 

Thanks, 
qrz

-------------------------------------------------
This mail sent through IMP: http://horde.org/imp/

