Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262530AbUKLNGz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262530AbUKLNGz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 08:06:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262526AbUKLNF0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 08:05:26 -0500
Received: from witte.sonytel.be ([80.88.33.193]:10221 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262529AbUKLNEp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 08:04:45 -0500
Date: Fri, 12 Nov 2004 14:04:33 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Andries Brouwer <Andries.Brouwer@cwi.nl>
cc: Kyle Moffett <mrmacman_g4@mac.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] remove if !PARTITION_ADVANCED condition in defaults
In-Reply-To: <20041112122052.GA13342@apps.cwi.nl>
Message-ID: <Pine.GSO.4.61.0411121402570.27077@waterleaf.sonytel.be>
References: <200411112302.iABN2Pu01711@apps.cwi.nl>
 <Pine.LNX.4.58.0411111507090.2301@ppc970.osdl.org> <CB00AF16-344E-11D9-857E-000393ACC76E@mac.com>
 <Pine.GSO.4.61.0411121242340.27077@waterleaf.sonytel.be>
 <20041112122052.GA13342@apps.cwi.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Nov 2004, Andries Brouwer wrote:
> On Fri, Nov 12, 2004 at 12:50:21PM +0100, Geert Uytterhoeven wrote:
> (wild reaction snipped)
> 
> Geert, have you tried?
> Didnt you discover that the patch is perfect?
> 
> I get the impression that your reaction was written without reading
> what was changed.
> 
> But if anything is wrong, please say explicitly what.

Sorry, I shouldn't do email when I'm ill...

On a second read, it indeed looks perfect. I missed the already existing `if
PARTITION_ADVANCED' at the end of each `bool "..."' line.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
