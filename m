Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132372AbRCZHjB>; Mon, 26 Mar 2001 02:39:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132381AbRCZHiv>; Mon, 26 Mar 2001 02:38:51 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:52456 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S132372AbRCZHik>;
	Mon, 26 Mar 2001 02:38:40 -0500
Message-ID: <3ABEF1D2.3798E7FE@mandrakesoft.com>
Date: Mon, 26 Mar 2001 02:37:54 -0500
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
In-Reply-To: <200103260001.f2Q01Yt09387@snark.thyrsus.com> <15038.56527.591553.87791@wire.cadcamlab.org> <3ABEE0B5.12A2F768@mandrakesoft.com> <3ABEE4C0.36EB75F5@mandrakesoft.com> <20010326020902.C11181@thyrsus.com> <3ABEEDBF.8DA84193@mandrakesoft.com> <20010326023007.A12481@thyrsus.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric S. Raymond" wrote:
> Jeff Garzik <jgarzik@mandrakesoft.com>:
> > You updated Linux-Mandrake's kernel RPM and Linux-Mandrake's installer?
> > Cool!

> No, I didn't.  But I can't even imagine how these changes could break those.

Our kernel build process has to look at CONFIG_xxx because we build
multiple kernels from the same base .config.


> > Please post a patch with only these 19 changes, and make sure to CC it
> > to linux-kernel.

> I don't think this is your decision to make, is it?

I have no control over what you choose to do.  It's a free 'net, and you
are free to ignore any and all suggestions.

The normal way to get patches into the kernel is to split them up.  I
just sent Linus 21 patches, which got condensed into

> -pre8:
> [...]
>   - Jeff Garzik: network driver updates, i810 rng driver, and
>     "alloc_etherdev()" network driver insert race condition fix.

Separate out your changes.  Make the maintainers aware of your changes. 
ie. if it modifies my driver's CONFIG_xxx usage or my subsystem's
Config.in, let me know.  ("me" == any maintainer)

Read Documentation/SubmittingPatches.

	Jeff


-- 
Jeff Garzik       | May you have warm words on a cold evening,
Building 1024     | a full moon on a dark night,
MandrakeSoft      | and a smooth road all the way to your door.
