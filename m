Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263330AbTKYWzy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 17:55:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263402AbTKYWzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 17:55:54 -0500
Received: from Thales.MI.Uni-Koeln.DE ([134.95.213.2]:23465 "EHLO
	Thales.MI.Uni-Koeln.DE") by vger.kernel.org with ESMTP
	id S263330AbTKYWzx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 17:55:53 -0500
Date: Tue, 25 Nov 2003 23:55:51 +0100 (MET)
From: Klaus Niederkrueger <kniederk@math.uni-koeln.de>
X-X-Sender: kniederk@Thales
To: linux-kernel@vger.kernel.org
Subject: XFree freezes with 2.6.0-pre
Message-ID: <Pine.GSO.4.44.0311252337500.8898-100000@Thales>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sorry, if I'm not meant to post on this list.

I have been noticing the following bug with kernel 2.6.0-pre8 up to pre10.
My XFree-4.3.0 freezes completely on a very irregular base spontaneously
or reproducibly if I use "wine" with certain programs.

Since I have no network, I can not try ssh, but the NumLock-key still
swithces on/off the LED on the keyboard, after X has frozen.

I have tried to switch preemptible kernel on and off, but it does not make
a big difference.

Starting a (freeware) game called "dink smallwood" under wine, crashes
XFree reproducibly. Before everything stops, I can see that the shell from
which I started wine fills with error messages "signal 0 can not be
handled" (to be honest, I forgot the exact message, but it was something
like this). Under kernel 2.4.21 everything works (at least X does not
crash).

My setup is: SMP-Duron (I know, not officially supported, but under 2.4.21
I have no problems). Asus-board with 768MPX-chipset. Radeon-Card and
SuSE-8.2 distro with all SuSE-patches installed and the latest wine from
SuSE-package (people/meissner/...).

I hope this helps, if not I can try to answer questions.

Cheers

	Klaus

