Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265367AbUATL3e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 06:29:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265364AbUATL3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 06:29:32 -0500
Received: from gate.crashing.org ([63.228.1.57]:39124 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265367AbUATL3a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 06:29:30 -0500
Subject: Re: Help port swsusp to ppc.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       ncunningham@users.sourceforge.net, Hugang <hugang@soulinfo.com>,
       ncunningham@clear.net.nz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Debian GNU/Linux PPC <debian-powerpc@lists.debian.org>
In-Reply-To: <20040120100405.GB183@elf.ucw.cz>
References: <20040119105237.62a43f65@localhost>
	 <1074483354.10595.5.camel@gaston> <1074489645.2111.8.camel@laptop-linux>
	 <1074490463.10595.16.camel@gaston> <20040119204551.GB380@elf.ucw.cz>
	 <1074555531.10595.89.camel@gaston>
	 <Pine.GSO.4.58.0401201052320.18625@waterleaf.sonytel.be>
	 <20040120100405.GB183@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1074598014.739.7.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 20 Jan 2004 22:26:54 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-01-20 at 21:04, Pavel Machek wrote:

> Well, *all* the data pages are saved, so that would be okay (even if
> they changed, as I'm replacing all the data pages, that should work),
> but I'm not saving kernel text for example.

Ahh... that's an interesting point. You aren't saving kernel text. I'm
not sure how that could be a problem for me. I think i'll just save it
along with the image though. I think there is much risk screwing up
because an uncompatible boot/load kernel pair here than because devices
aren't fully idle.

Ben.


