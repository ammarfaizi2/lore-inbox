Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262092AbTH3U3k (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 16:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262113AbTH3U3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 16:29:39 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:13784 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S262092AbTH3U3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 16:29:39 -0400
Date: Sat, 30 Aug 2003 17:25:20 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Soeren Sonnenburg <kernel@nn7.de>
Cc: lkml <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Freeze with HPT370 2.4.22-rc2 and dxr3
Message-ID: <Pine.LNX.4.55L.0308301721390.31768@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> When I play a movie through the dxr3 (driver form dxr3.sf.net) it used
> to work just fine for quite a long time.
> However now that I use a software raid (one via ide on asus a7v8x and 2
> hpt370) I can reproducably get the system to freeze when I mplayer -vo
> dxr3 <file_on_sw_raid> after less than 10 minutes.

> Then the IDE lid is continuously on until I reset the machine.

> I found out that when I copy the file to a ram disk and then play it
> through dxr3 it works just fine (no freeze). This happens even when I
> boot with init=/bin/sh (so no nvidia or other binary only modules).

> Any ideas on what to try out ?

Does the same happen with 2.4.20 or 2.4.21? (try with no binary modules
please)
