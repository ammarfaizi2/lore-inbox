Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbRAEPiy>; Fri, 5 Jan 2001 10:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129383AbRAEPio>; Fri, 5 Jan 2001 10:38:44 -0500
Received: from mail.zmailer.org ([194.252.70.162]:29452 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S129183AbRAEPif>;
	Fri, 5 Jan 2001 10:38:35 -0500
Date: Fri, 5 Jan 2001 17:38:08 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: jgarzik@mandrakesoft.com, mea@nic.funet.fi, linux-kernel@vger.kernel.org
Subject: Re: 2.4.0 tulip bug (was: And oh, btw..)
Message-ID: <20010105173808.P12545@mea-ext.zmailer.org>
In-Reply-To: <200101051523.QAA26873@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200101051523.QAA26873@harpo.it.uu.se>; from mikpe@csd.uu.se on Fri, Jan 05, 2001 at 04:23:13PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 05, 2001 at 04:23:13PM +0100, Mikael Pettersson wrote:
> >Changes since the prerelease:
> >...
> >Matti Aarnio:
> > - teach tulip driver about media types 5 and 6
>
> This part of the patch introduces a bug in 2.4.0, as noticed by gcc:

	Oddly enough the beast works with my test specimen,
	but real analysis is still incomplete by Donald et.al.

	So far we think that if the card has MII (type 1) media,
	it could safely ignore types 5 and 6.

> The patch also adds four unused variables, which looks rather fishy.

	Indeed, it is copy&paste from somewhere else, which may
	indeed have different control flows.

	However unless you have esoteric (taiwanese) special hardware
	with those media types, it won't affect you.

> /Mikael

/Matti Aarnio
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
