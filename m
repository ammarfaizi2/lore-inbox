Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965130AbWEaT5Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965130AbWEaT5Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 15:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751794AbWEaT5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 15:57:24 -0400
Received: from nz-out-0102.google.com ([64.233.162.196]:52253 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751793AbWEaT5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 15:57:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=U24vpFrziNMmzz8xScleGBhHURcdDXzk6eGg6EkBMOu6YZrLUcI6Uv7pSqqruHeh5FaSJW9TFCbD/Wxws5NqbUKr/2m4oPoYoT81bP3NccmlgXcpLj3YkG9JunSm0Ys7XCIzQzNd5TbQQLepsQGJLdh4ctnerGB4A/MAS2ZOWus=
Message-ID: <9e4733910605311257m19450bbai4c3ae6fdc7909a4@mail.gmail.com>
Date: Wed, 31 May 2006 15:57:23 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Geert Uytterhoeven" <geert@linux-m68k.org>
Subject: Re: OpenGL-based framebuffer concepts
Cc: "Antonino A. Daplas" <adaplas@gmail.com>,
       "Ondrej Zajicek" <santiago@mail.cz>,
       "Linux Kernel Development" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0605312033260.16745@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
	 <200605272245.22320.dhazelton@enter.net>
	 <9e4733910605272027o7b59ea5n5d402dabdd7167cb@mail.gmail.com>
	 <200605280112.01639.dhazelton@enter.net>
	 <21d7e9970605281613y3c44095bu116a84a66f5ba1d7@mail.gmail.com>
	 <9e4733910605281759j2e7bebe1h6e3f2bf1bdc3fc50@mail.gmail.com>
	 <Pine.LNX.4.63.0605301033330.4786@qynat.qvtvafvgr.pbz>
	 <20060530223513.GA32267@localhost.localdomain>
	 <447CD367.5050606@gmail.com>
	 <Pine.LNX.4.62.0605312033260.16745@pademelon.sonytel.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/06, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Wed, 31 May 2006, Antonino A. Daplas wrote:
> > And it can be done.  The matrox driver in 2.4 can do just that.  For 2.6,
> > we have tileblitting which is a drawing method that can handle pure text.
> > None of the drivers use this, but vgacon can be trivially written as a
> > framebuffer driver that uses tileblitting (instead of the default bitblit).
> >
> > I believe that there was a vgafb driver before that does exactly what you
> > want.
>
> Indeed. Early 2.1.x had a vgafb and an fbcon-vga, before vgacon existed in its
> current form.

Moving back to a vgafb with text mode support in fbcon would be one
way to eliminate a few of the way too many graphics drivers. I don't
see any real downside side to doing this, does any one else see any
problems?


-- 
Jon Smirl
jonsmirl@gmail.com
