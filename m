Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263041AbUFSApr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263041AbUFSApr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 20:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263596AbUFSAnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 20:43:07 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41367 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261925AbUFSAdn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 20:33:43 -0400
Date: Sat, 19 Jun 2004 01:33:42 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cross-sparse
Message-ID: <20040619003342.GP12308@parcelfarce.linux.theplanet.co.uk>
References: <Pine.GSO.4.58.0406172304170.1495@waterleaf.sonytel.be> <Pine.LNX.4.58.0406180925210.4669@ppc970.osdl.org> <Pine.GSO.4.58.0406182245540.23356@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0406182245540.23356@waterleaf.sonytel.be>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2004 at 10:49:38PM +0200, Geert Uytterhoeven wrote:
> And even the non-native sparse doesn't know about architecture-specific defines
> like __mc68000__, causing some code paths being wrong. Guess I have to replace
> them by e.g. CONFIG_M68K.

That should be handled in arch/m68k/Makefile - see how it's done on e.g.
i386.
