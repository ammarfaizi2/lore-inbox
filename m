Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751109AbWE2C24@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbWE2C24 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 22:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbWE2C24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 22:28:56 -0400
Received: from nz-out-0102.google.com ([64.233.162.201]:53745 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751109AbWE2C2z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 22:28:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=I7S5rNclFigrIzd9ZW8HnEzEs9DTe+LuvFq5620vTBeOYA7DVUn1sQeJ9M//RDPrwyoGEuG2Nv+sE5pDXTfeXmu0lTQ1qrwPY11MDVp73OMy2jBZKzmbtZgoFqsD2IoolmPIzuzRXM7n2Lixs21iCxxz/xUz/V2g8edu2HYTRZ4=
Message-ID: <9e4733910605281928h7eb8b8d7j668a1a38edb3de96@mail.gmail.com>
Date: Sun, 28 May 2006 22:28:53 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Jon Smirl" <jonsmirl@gmail.com>, "Dave Airlie" <airlied@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: OpenGL-based framebuffer concepts
In-Reply-To: <20060529012933.GR16521@fooishbar.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
	 <200605272245.22320.dhazelton@enter.net>
	 <9e4733910605272027o7b59ea5n5d402dabdd7167cb@mail.gmail.com>
	 <200605280112.01639.dhazelton@enter.net>
	 <21d7e9970605281613y3c44095bu116a84a66f5ba1d7@mail.gmail.com>
	 <9e4733910605281759j2e7bebe1h6e3f2bf1bdc3fc50@mail.gmail.com>
	 <20060529012933.GR16521@fooishbar.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/28/06, Daniel Stone <daniel@fooishbar.org> wrote:
> On Sun, May 28, 2006 at 08:59:19PM -0400, Jon Smirl wrote:
> > On 5/28/06, Dave Airlie <airlied@gmail.com> wrote:
> > >c) Lots of distros don't use fbdev drivers, forcing this on them to
> > >use drm isn't an option.
> >
> > Why isn't this an option? Will the distros that insist on continuing
> > to ship three conflicting video drivers fighting over a single piece
> > of hardware please stand up and be counted? Distros get new drivers
> > all the time, why will this be any different?
>
> Often they flat-out don't work.  Walk into a store and buy a random
> laptop.  Odds are it uses an Intel graphics chip.  Now load intelfb on
> this.  Watch it completely fail to set a mode, as intelfb has no
> knowledge beyond what the CRTC was like on i810.

If you read the whole thread you will see that we're only talking
about binding the existing DRM and fbdev drivers together. I believe I
said "This is just the first step down a long path to making the
merged drivers work." We can talk all we want be forward progress
never seems to happen - we have to start somewhere.

>
> The support offered by fbdev drivers is laughable in comparison to the
> support offered by X drivers.  If you're lucky, it fails cleanly.  If
> not, you're silently failing to get a working display.
>
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.2.2 (GNU/Linux)
>
> iD8DBQFEek59RkzMgPKxYGwRAmstAJ0cz8m7JVtOs3GfioNKvKmRWZoAygCferj1
> rO+SzW1gg2qxZwWe/o4W+7Q=
> =mjgG
> -----END PGP SIGNATURE-----
>
>
>


-- 
Jon Smirl
jonsmirl@gmail.com
