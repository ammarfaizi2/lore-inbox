Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265200AbUASPPq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 10:15:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265215AbUASPPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 10:15:46 -0500
Received: from witte.sonytel.be ([80.88.33.193]:38595 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S265200AbUASPPp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 10:15:45 -0500
Date: Mon, 19 Jan 2004 16:15:38 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Rik van Riel <riel@redhat.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.25-pre5
In-Reply-To: <Pine.LNX.4.58L.0401151816320.17528@logos.cnet>
Message-ID: <Pine.GSO.4.58.0401191611460.551@waterleaf.sonytel.be>
References: <Pine.LNX.4.58L.0401151816320.17528@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jan 2004, Marcelo Tosatti wrote:
> Summary of changes from v2.4.25-pre4 to v2.4.25-pre5
> ============================================
>
> Rik van Riel:
>   o Reclaim inodes with highmem pages when low on memory

This introduces a warning when compiling fs/inode.c if CONFIG_HIGHMEM is not
set, since in that case avg_pages is defined but not used.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
