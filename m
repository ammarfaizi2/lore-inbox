Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269370AbUICIWc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269370AbUICIWc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 04:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269393AbUICITG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 04:19:06 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:26117 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S269374AbUICIRj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 04:17:39 -0400
Date: Fri, 3 Sep 2004 09:13:52 +0100
From: Christoph Hellwig <hch@infradead.org>
To: David Masover <ninja@slaphack.com>
Cc: Oliver Neukum <oliver@neukum.org>, Spam <spam@tnonline.net>,
       Hans Reiser <reiser@namesys.com>, Linus Torvalds <torvalds@osdl.org>,
       Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives
Message-ID: <20040903091352.A2288@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Masover <ninja@slaphack.com>,
	Oliver Neukum <oliver@neukum.org>, Spam <spam@tnonline.net>,
	Hans Reiser <reiser@namesys.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Jamie Lokier <jamie@shareable.org>,
	Horst von Brand <vonbrand@inf.utfsm.cl>,
	Adrian Bunk <bunk@fs.tum.de>,
	viro@parcelfarce.linux.theplanet.co.uk,
	Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Lyamin aka FLX <flx@namesys.com>,
	ReiserFS List <reiserfs-list@namesys.com>
References: <20040826150202.GE5733@mail.shareable.org> <4136E0B6.4000705@namesys.com> <1117111836.20040902115249@tnonline.net> <200409021309.04780.oliver@neukum.org> <4137BE36.5020504@slaphack.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4137BE36.5020504@slaphack.com>; from ninja@slaphack.com on Thu, Sep 02, 2004 at 07:43:34PM -0500
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2004 at 07:43:34PM -0500, David Masover wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Oliver Neukum wrote:
> | Am Donnerstag, 2. September 2004 11:52 schrieb Spam:
> |
> |>  Btw, version control for ordinary files would be a great feature. I
> |>  think something like it is available through Windows 2000/3 server.
> |>  Isn't it called "Shadow Copies". It works over network shares. :)
> |>
> |>  It allows you to restore previous versions of the file even if you
> |>  delete or overwrite it.
> |
> |
> | There's no need to do that in kernel, unless you want to be able
> | to force it unto users.
> 
> And on apps.  Should I teach OpenOffice.org to do version control?
> Seems a lot easier to just do it in the kernel, and teach everything to
> do version control in one fell swoop.

Just add a post-save trigger that can check it into any SCM you want.

