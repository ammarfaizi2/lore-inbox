Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932118AbVLLS3Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbVLLS3Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 13:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932126AbVLLS3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 13:29:24 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:55710 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932118AbVLLS3Y convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 13:29:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gKt+pVj4z5KqdHFgUzG26Y87c+t4TytMFg6WrOIqJKZLQcbYCtAMY2FhbhkPUnSp+/hbmectxVKUKOpWzXpmCSNP7WNYxmsf/Dq6y47flvFM/BycW/I9mIDsSg/7R+iKm3BekZ9TiH87t6nv3gL4/44l7A5hikWVycPlo4GaSfo=
Message-ID: <808c8e9d0512121029p4215d8b9y411a76d54f625677@mail.gmail.com>
Date: Mon, 12 Dec 2005 12:29:23 -0600
From: Ben Gardner <gardner.ben@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Subject: 2.6.15-rc5-mm2: two cs5535 modules
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20051211175612.GL23349@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051211041308.7bb19454.akpm@osdl.org>
	 <20051211175612.GL23349@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

Thanks for pointing that out. I'll use a different name.

Perhaps the cs5535 ide module should also be renamed to something more
sane, like "cs5535-ide".

Ben

On 12/11/05, Adrian Bunk <bunk@stusta.de> wrote:
> On Sun, Dec 11, 2005 at 04:13:08AM -0800, Andrew Morton wrote:
> >...
> > Changes since 2.6.15-rc5-mm1:
> >...
> > +i386-cs5535-chip-support-cpu.patch
> >...
> >  Updated.   Still need work.
> >...
>
> This patch adds a module cs5535 under arch/i386/kernel/, but there's
> already a module of the same name present under drivers/ide/pci/.
>
> This is a problem if both are modular since two modules of the same name
> are not possible.
>
> cu
> Adrian
>
> --
>
>        "Is there not promise of rain?" Ling Tan asked suddenly out
>         of the darkness. There had been need of rain for many days.
>        "Only a promise," Lao Er said.
>                                        Pearl S. Buck - Dragon Seed
>
>
