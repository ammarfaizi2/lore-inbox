Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751162AbWCWGKA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbWCWGKA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 01:10:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbWCWGJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 01:09:59 -0500
Received: from nproxy.gmail.com ([64.233.182.198]:18107 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751162AbWCWGJ6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 01:09:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tt2r4L9VTB/6pxv736fSAaNI+fSSmKArSGZjLSDXIc21fzPYSobvwA1ZeFqyoTVEHB0TxCMpz0vSz3ns0w8UwcMXRNft9NCDohlRpmAj1sPqHnPC6Q8J5EUCgDlQufWJOF+WVFeLQmRFEj6E+4XyHLhtT/gI3rTQlkkPhzL1PR4=
Message-ID: <21d7e9970603222209r45beeb99nccc6435b99b79154@mail.gmail.com>
Date: Thu, 23 Mar 2006 17:09:56 +1100
From: "Dave Airlie" <airlied@gmail.com>
To: linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [Linux-fbdev-devel] [PATCH] [git tree] Intel i9xx support for intelfb
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       sylvain.meyer@worldonline.fr, akpm@osdl.org
In-Reply-To: <b00ca3bd0603222159t63ea0f4j38e085ecff5b93c8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <21d7e9970603221820p5c89e46fgbd9878a3c60eac0a@mail.gmail.com>
	 <b00ca3bd0603222159t63ea0f4j38e085ecff5b93c8@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > This code isn't perfect but I've got no documentation so I cannot
> > answer some questions on what exactly is going on just yet...
>
> Better than nothing, and if it works for digital displays, then that
> would be great.

It doesn't support LVDS or DVI yet but I'm hoping to make it go in
that direction, I've no LVDS h/w, and some chipsets have it integrated
and some don't, but this is a better basis for future work, and I'll
have no problems keeping it updated with fixes as they come from the
X.org driver... I'd like to get at least LVDS support working for
laptop users with these chipsets, getting DVI working is a bit more
work as there are external chips that need to be driven over i2c, so
I'll need to at least add i2c support to the i8xx driver. (I noticed
Sylvain has done some of this work before)..... I'd like to expose i2c
buses to userspace anyways....

> There's no git tree for the framebuffer layer, I just send updates
> directly to akpm. Andrew?
>

I'd like to keep the git history if possible, so maybe we can pull
this tree into -mm and I can get it pulled by Linus later.

Regards,
Dave
