Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265457AbUAPMQR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 07:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265463AbUAPMQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 07:16:13 -0500
Received: from witte.sonytel.be ([80.88.33.193]:17821 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S265457AbUAPMQJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 07:16:09 -0500
Date: Fri, 16 Jan 2004 13:16:02 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jeff Dike <jdike@addtoit.com>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] /dev/anon
In-Reply-To: <200401132021.i0DKLBhg002890@ccure.user-mode-linux.org>
Message-ID: <Pine.GSO.4.58.0401161314590.14892@waterleaf.sonytel.be>
References: <200401132021.i0DKLBhg002890@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jan 2004, Jeff Dike wrote:
> If this should be maintained out-of-tree, should I get an official minor for
> it anyway, or just unofficially use the first unused misc minor (10 in 2.4,
> 11 in 2.6)?

Apparently there's a hole in the list in 2.6.[01] (/dev/kmsg has 11), so you
can use 10 for both 2.4 and 2.6.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
