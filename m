Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268717AbUJTQqK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268717AbUJTQqK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 12:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268655AbUJTQpu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 12:45:50 -0400
Received: from witte.sonytel.be ([80.88.33.193]:14309 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S268490AbUJTQmz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 12:42:55 -0400
Date: Wed, 20 Oct 2004 18:42:38 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: David Howells <dhowells@redhat.com>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-m68k@vger.kernel.org, uClinux list <uclinux-dev@uclinux.org>
Subject: Re: [PATCH] Add key management syscalls to non-i386 archs
In-Reply-To: <3506.1098283455@redhat.com>
Message-ID: <Pine.GSO.4.61.0410201840440.6837@waterleaf.sonytel.be>
References: <3506.1098283455@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Oct 2004, David Howells wrote:
> The attached patch adds syscalls for almost all archs (everything barring
> m68knommu which is in a real mess, and i386 which already has it).

m68nommu mirrors m68k now, but that patch doesn't seem to be in Linus' tree
yet.

Anyway, I'll reserve 3 syscalls for m68k, together with the other pending
syscall numbers.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
