Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262902AbUEBIk6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262902AbUEBIk6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 04:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262905AbUEBIk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 04:40:58 -0400
Received: from witte.sonytel.be ([80.88.33.193]:24566 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262902AbUEBIk5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 04:40:57 -0400
Date: Sun, 2 May 2004 10:40:28 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Giuliano Colla <copeca@copeca.dsnet.it>
cc: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>,
       Linus Torvalds <torvalds@osdl.org>, hsflinux@lists.mbsi.ca,
       Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [hsflinux] [PATCH] Blacklist binary-only modules lying about
 their license
In-Reply-To: <4092A88D.70007@copeca.dsnet.it>
Message-ID: <Pine.GSO.4.58.0405021030410.7925@waterleaf.sonytel.be>
References: <408DC0E0.7090500@gmx.net> <40914C35.1030802@copeca.dsnet.it>
 <Pine.LNX.4.58.0404291404100.1629@ppc970.osdl.org> <409256A4.5080607@copeca.dsnet.it>
 <409276D6.9070500@gmx.net> <4092A88D.70007@copeca.dsnet.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Apr 2004, Giuliano Colla wrote:
> It may make sense not to have anything left in the GPL directory in a
> binary only .rpm package, because once linked GPL parts cannot be told
> apart from non-GPL ones.

When speaking about loadable kernel modules: yes they can! That's what
modinfo(8) is for!

Oh wait, someone played tricks with a \0 character...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
