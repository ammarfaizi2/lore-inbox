Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132370AbRCZHVl>; Mon, 26 Mar 2001 02:21:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132371AbRCZHVb>; Mon, 26 Mar 2001 02:21:31 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:45032 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S132370AbRCZHVQ>;
	Mon, 26 Mar 2001 02:21:16 -0500
Message-ID: <3ABEEDBF.8DA84193@mandrakesoft.com>
Date: Mon, 26 Mar 2001 02:20:31 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: esr@thyrsus.com
Cc: "Eric S. Raymond" <esr@snark.thyrsus.com>,
        Peter Samuelson <peter@cadcamlab.org>, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
Subject: Re: CML1 cleanup patch
In-Reply-To: <200103260001.f2Q01Yt09387@snark.thyrsus.com> <15038.56527.591553.87791@wire.cadcamlab.org> <3ABEE0B5.12A2F768@mandrakesoft.com> <3ABEE4C0.36EB75F5@mandrakesoft.com> <20010326020902.C11181@thyrsus.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric S. Raymond" wrote:
> Jeff Garzik <jgarzik@mandrakesoft.com>:
> > FWIW I am opposed to any large-scale cleanup of the configuration
> > language and/or identifiers in -any- 2.4.x series kernel.
> 
> This is tweaking 39 symbols out of 1831, hardly large-scale.  These
> irregularities in the namespace cause trouble out of all proportion to
> their size, is my problem.  If you knew what I've been through trying
> to write analysis tools...*shudder*...

They cause trouble for you, solely, at the moment.  Changing the CML1
namespace potentially causes trouble for many people.


> > Not only C code but installer utilities are affected by changes in the
> > CONFIG_xxx identifiers.  If we change that namespace, we are changing
> > part of the API that is exported to drivers.  Definitely not 2.4.x
> > stuff.
> 
> My patch fixes those installer utilities.  All three of them.  And no driver
> code is or possibly could be broken by it, that's a red herring.  *No
> object code will change as a result of this patch*.

You updated Linux-Mandrake's kernel RPM and Linux-Mandrake's installer? 
Cool!


> I want this in before the 2.5 fork for several reasons:
> 
> (1) 19 of the 39 changes fix things that are outright bugs even in CML1.
>     These should not be allowed to persist in the stable branch.

Please post a patch with only these 19 changes, and make sure to CC it
to linux-kernel.

Thanks,

	Jeff


-- 
Jeff Garzik       | May you have warm words on a cold evening,
Building 1024     | a full moon on a dark night,
MandrakeSoft      | and a smooth road all the way to your door.
