Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132439AbRALUes>; Fri, 12 Jan 2001 15:34:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132384AbRALUei>; Fri, 12 Jan 2001 15:34:38 -0500
Received: from mail.zmailer.org ([194.252.70.162]:12296 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S131765AbRALUeX>;
	Fri, 12 Jan 2001 15:34:23 -0500
Date: Fri, 12 Jan 2001 22:34:15 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: "H. Peter Anvin" <hpa@transmeta.com>
Cc: Andries.Brouwer@cwi.nl, ftpadmin@kernel.org, jmd@foozle.turbogeek.org,
        linux-kernel@vger.kernel.org
Subject: Re: kernel.org signer broken?
Message-ID: <20010112223415.J25659@mea-ext.zmailer.org>
In-Reply-To: <UTC200101121456.PAA105954.aeb@ark.cwi.nl> <3A5F67D4.D096B191@transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A5F67D4.D096B191@transmeta.com>; from hpa@transmeta.com on Fri, Jan 12, 2001 at 12:23:48PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12, 2001 at 12:23:48PM -0800, H. Peter Anvin wrote:
> Andries.Brouwer@cwi.nl wrote:
> > > The signature on man-pages-1.34.tar.gz is bad:
> > 
> > Hmm, thought I had corrected that already.
> > Is it correct now?
> > 
> > Andries
> 
> Because an updated signature has the same timestamp and size, it can take
> up to 24 hours for it to hit ftp.kernel.org, and even longer to propagate
> to the mirrors, unfortunately.

	Ok, then rsync  won't find it either unless driven in
	file CRC verification mode (which is not usual...)

	You *must* change its time (e.g. with touch).

> 	-hpa
> -- 
> <hpa@transmeta.com> at work, <hpa@zytor.com> in private!

/Matti Aarnio
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
