Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275367AbTHISwp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 14:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275370AbTHISwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 14:52:45 -0400
Received: from fw.osdl.org ([65.172.181.6]:43918 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S275367AbTHISwo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 14:52:44 -0400
Date: Sat, 9 Aug 2003 11:52:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: "ismail (cartman) donmez" <kde@myrealbox.com>
Cc: tmolina@cablespeed.com, linux-kernel@vger.kernel.org,
       James Simmons <jsimmons@infradead.org>
Subject: Re: Linux 2.6.0-test3: logo patch
Message-Id: <20030809115245.7ef1ff59.akpm@osdl.org>
In-Reply-To: <200308091927.04894.kde@myrealbox.com>
References: <Pine.LNX.4.44.0308091059490.2587-100000@localhost.localdomain>
	<200308091927.04894.kde@myrealbox.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"ismail (cartman) donmez" <kde@myrealbox.com> wrote:
>
> Patch somehow got out of -mm tree too. Andrew can you please apply this  too ?
> > The following patch has been floating around forever.  Can we get it in
> > mainstream sometime in the near future?
> >
> > --- linux-2.5-tm/drivers/video/cfbimgblt.c.orig	2003-08-08
> > 17:42:16.000000000 -0500 +++
> > linux-2.5-tm/drivers/video/cfbimgblt.c	2003-08-08 17:42:30.000000000 -0500
> > @@ -325,7 +325,7 @@
> >  		else
> >  			slow_imageblit(image, p, dst1, fgcolor, bgcolor,
> >  					start_index, pitch_index);
> > -	} else if (image->depth == bpp)
> > +	} else if (image->depth <= bpp)
> >  		color_imageblit(image, p, dst1, start_index, pitch_index);
> >  }
> >
> >

This change was also present in James's fbdev update, so I dropped it.  But
then James's fbdev update broke so I dropped that too.

James was going to send me an updated patch.  Hint. :)


