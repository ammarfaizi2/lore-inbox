Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262097AbTEEIa2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 04:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262098AbTEEIa2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 04:30:28 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:14735 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id S262097AbTEEIa1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 04:30:27 -0400
Date: Mon, 5 May 2003 10:42:35 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Gabriel Devenyi <devenyga@mcmaster.ca>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.68] KernelJanitor - Change applicable char *foo to
 char foo[]
In-Reply-To: <200305051953.16285.devenyga@mcmaster.ca>
Message-ID: <Pine.GSO.4.21.0305051042120.9126-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 May 2003, Gabriel Devenyi wrote:
> This patch applies to Linux 2.5.68. It converts appropriate string declarations(those which are only read) to the memory saving char foo[] version.
> 
> http://muss.mcmaster.ca/~devenyga/linux-2.5.68-char-changes.patch
> 
> Please CC me with any discussion.

Why don't you make all of them const while you're at it?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

