Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262068AbUKVK72@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262068AbUKVK72 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 05:59:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262058AbUKVK6G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 05:58:06 -0500
Received: from witte.sonytel.be ([80.88.33.193]:51453 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262068AbUKVKyi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 05:54:38 -0500
Date: Mon, 22 Nov 2004 11:54:20 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Sohail Somani <sohail@sohailsomani.com>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org
Subject: Re: [PATCH 475] HP300 LANCE
In-Reply-To: <1101083116.20032.0.camel@localhost>
Message-ID: <Pine.GSO.4.61.0411221153320.7323@waterleaf.sonytel.be>
References: <200410311003.i9VA3UMN009557@anakin.of.borg>
 <20041101142245.GA28253@infradead.org> <20041116084341.GA24484@infradead.org>
 <20041116231248.5f61e489.akpm@osdl.org> <Pine.GSO.4.61.0411211059500.19680@waterleaf.sonytel.be>
 <20041121161244.1a5ff193.akpm@osdl.org> <1101083116.20032.0.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Nov 2004, Sohail Somani wrote:
> On Sun, 2004-11-21 at 16:12 -0800, Andrew Morton wrote:
> > +#define dio_resource_len(d) \
> > +       ((d)->resource.end - (d)->resource.start)
> > 
> > but dio.h has:
> > 
> > #define dio_resource_len(d)   ((d)->resource.end-(z)->resource.start+1)
> > 
> > 
> > Which is correct?
> 
> Where did z come from in the second definition anyway?

I guess it got copied from linux/zorro.h...
It's a bug which went unnoticed, and got fixed in the mean time.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
