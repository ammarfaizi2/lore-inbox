Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267563AbUJVUQF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267563AbUJVUQF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 16:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267515AbUJVUPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 16:15:43 -0400
Received: from witte.sonytel.be ([80.88.33.193]:133 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S267404AbUJVUJ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 16:09:29 -0400
Date: Fri, 22 Oct 2004 22:09:27 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "J.A. Magallon" <jamagallon@able.es>
cc: Timothy Miller <theosib@yahoo.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
In-Reply-To: <1098318640l.25188l.0l@werewolf.able.es>
Message-ID: <Pine.GSO.4.61.0410222207340.11567@waterleaf.sonytel.be>
References: <20041020234819.23232.qmail@web40706.mail.yahoo.com>
 <1098318640l.25188l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Oct 2004, J.A. Magallon wrote:
> So, as I see it, for an appealing 2D card, you need to program a 2 1/2
> graphics engine, with really _fast_ alpha blending and antialiasing.
> You can only kill the matrix part. I do not know if you will be able to
> get rid completely of floating point, for those alpha mixes and assorted
> candy...

Alpha blending (and Porter-Duff operations in general) can easily be done in
integer. You do want to read Rasterman's excellent comments in the Imlib2
sources, though.

Been there, done that... (for a STB without FPU and without hardware blending)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
