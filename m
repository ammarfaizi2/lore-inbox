Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129103AbQKHGjj>; Wed, 8 Nov 2000 01:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129337AbQKHGj3>; Wed, 8 Nov 2000 01:39:29 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:17416 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129103AbQKHGjR>; Wed, 8 Nov 2000 01:39:17 -0500
Date: Wed, 8 Nov 2000 00:35:08 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: "H. Peter Anvin" <hpa@transmeta.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        "Jeff V. Merkey" <jmerkey@timpanogas.org>, kernel@kvack.org,
        Tigran Aivazian <tigran@veritas.com>, linux-kernel@vger.kernel.org
Subject: Re: Installing kernel 2.4
Message-ID: <20001108003508.A9141@vger.timpanogas.org>
In-Reply-To: <Pine.LNX.3.96.1001107175009.1482C-100000@kanga.kvack.org> <3A088C02.4528F66B@timpanogas.org> <3A0896F3.AB36C3EE@mandrakesoft.com> <3A0897F5.563552AD@timpanogas.org> <3A089A01.ECAEABBD@mandrakesoft.com> <3A08B7E1.604191BB@transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3A08B7E1.604191BB@transmeta.com>; from hpa@transmeta.com on Tue, Nov 07, 2000 at 06:18:09PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2000 at 06:18:09PM -0800, H. Peter Anvin wrote:
> Jeff Garzik wrote:
> > 
> > "Jeff V. Merkey" wrote:
> > > We need a format that allow multiple executable segments to be combined
> > > in a single executable and the loader have enough smarts to grab the
> > > right one based on architecture.  two options:
> > >
> > > 1.  extend gcc to support this or rearragne linux into segments based on
> > > code type
> > > 2.  Use PE.
> > 
> > The kernel isn't going non-ELF.  Too painful, for dubious advantages,
> > namely:
> > 
> > The current gcc toolchain already supports what you suggest.
> > 
> > I understand that some people have even put some thought into a
> > bootloader that dynamically links your kernel on bootup, so this idea
> > isn't new.  It's a good idea though.
> > 
> 
> Yes, I have been working on it on and off for a while ("off" due to
> various professional and personal issues taking higher priority for some
> time...)


Keep truckin' H. Peter, this is something that's needed.

:-)

Jeff

> 
> 	-hpa
> 
> -- 
> <hpa@transmeta.com> at work, <hpa@zytor.com> in private!
> "Unix gives you enough rope to shoot yourself in the foot."
> http://www.zytor.com/~hpa/puzzle.txt
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
