Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262293AbUDTIjb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262293AbUDTIjb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 04:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262279AbUDTIjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 04:39:31 -0400
Received: from witte.sonytel.be ([80.88.33.193]:35287 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262293AbUDTIjQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 04:39:16 -0400
Date: Tue, 20 Apr 2004 10:39:13 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Guennadi Liakhovetski <gl@dsa-ac.de>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [somewhat OT] binary modules agaaaain
In-Reply-To: <Pine.LNX.4.33.0404191651300.1869-100000@pcgl.dsa-ac.de>
Message-ID: <Pine.GSO.4.58.0404201036270.21445@waterleaf.sonytel.be>
References: <Pine.LNX.4.33.0404191651300.1869-100000@pcgl.dsa-ac.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Apr 2004, Guennadi Liakhovetski wrote:
> A binary module is "considered good" if
>
> 1) It is accompanied by a "suitably licensed" (GPL-compatible) open-source
>    glue-module.
>
> 2) The sourced used to compile the binary part do not access any of the
>    kernel functionalities directly. Which means:
> 	a) they don't (need to) include any kernel header-files
> 	b) they don't access any kernel objects or methods directly
> 	c) all interfacing to the kernel goes over the glue module and the
> 	   interface is _purely functional_ - no macros, no inlines.

And for which architectures do they have to provide the binary-only part? 22
and still counting...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
