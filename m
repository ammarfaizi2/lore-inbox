Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267671AbTBLUnT>; Wed, 12 Feb 2003 15:43:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267674AbTBLUnS>; Wed, 12 Feb 2003 15:43:18 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:65017 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S267671AbTBLUnQ>;
	Wed, 12 Feb 2003 15:43:16 -0500
Date: Wed, 12 Feb 2003 21:51:25 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: James Simmons <jsimmons@infradead.org>
cc: Christoph Hellwig <hch@infradead.org>,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] Re: New logo code (fwd)
In-Reply-To: <Pine.LNX.4.44.0302122026550.31435-100000@phoenix.infradead.org>
Message-ID: <Pine.GSO.4.21.0302122149470.14562-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Feb 2003, James Simmons wrote:
> > > > All comments are welcomed! Thanks!
> > > 
> > > Come on, is there really no one to comment on this??
> > 
> > Except a question why it's not merged yet? :)
> 
> Looking for work has keot me busy. I merged it. One change I did do was 
> changed the CONFIG_FB_LOGO_* to CONFIG_LOGO_. In theory any one can use 
> the logo (i.e newport console). It is a much welcomed improvement. I 

OK.

> removed the hgafb logo code in the latest tree. It should use the standard 
> logo code. Also how should we go about for personal logos. Companies might 
> want to throw in there own thing which I have no issue with.

An option CONFIG_LOGO_USER, and a path CONFIG_LOGO_USER_PATH to a logo? Or
multiple user-specific logos (one of each type)?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

