Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274922AbTHNScI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 14:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275018AbTHNScI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 14:32:08 -0400
Received: from [63.226.249.57] ([63.226.249.57]:55239 "EHLO nymph.dleonard.net")
	by vger.kernel.org with ESMTP id S274922AbTHNScD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 14:32:03 -0400
Date: Thu, 14 Aug 2003 11:53:02 -0700 (PDT)
From: <dleonard@dleonard.net>
To: Mark Watts <m.watts@eris.qinetiq.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Via KT400 agpgart issues
In-Reply-To: <200308141025.12747.m.watts@eris.qinetiq.com>
Message-ID: <Pine.LNX.4.31.0308141129130.4489-100000@nymph.dleonard.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For my geforce3 and geforce4 I didn't notice anything odd about using the
KT400 chipset in spite of agpgart not fully supporting it.

For my fx5800 I actually *had* to use the nvidia agp driver to get
anything other than console mode to function.  Now it could be that I just
needed to drop the AGP rate to 4x in bios but frankly I didn't think of
that option until I'd already switched to using the nvidia code.  The
nvidia agp code has been behaving quite well under 2.4.20 and 2.4.22-pre*
for me.

-- 

<Douglas Leonard>
<dleonard@dleonard.net>

On Thu, 14 Aug 2003, Mark Watts wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
>
> Ok, I _am_ using the nVidia modules (on 2.4.21) but the fact that the agpgart
> driver can't sense my agp apature size is concerning... (its set to 256MB in
> the bios)
>
> 0: nvidia: loading NVIDIA Linux x86 nvidia.o Kernel Module  1.0-4496  Wed Jul
> 16 19:03:09 PDT 2003
> Linux agpgart interface v0.99 (c) Jeff Hartmann
> agpgart: Maximum main memory to use for agp memory: 439M
> agpgart: Detected Via Apollo Pro KT400 chipset
> agpgart: unable to determine aperture size.
> 0: NVRM: AGPGART: unable to retrieve symbol table
>
> I'm running a GeForce FX 5600 128Mb with AGP 3.0 support enabled.
> It seems to run ok, but its slower than the Ti 4200-4x I took out by a larger
> margin than it really should be (according to the benchmarks I've seen
> scattered through the internet.)
> I'm also running with the Local APIC turned on (it doesnt seem to break
> anything).
>
> Is anything actually broken or is this nothing to worry about?
>
> Cheers,
>
> Mark.
>
> - --
> Mark Watts
> Senior Systems Engineer
> QinetiQ TIM
> St Andrews Road, Malvern
> GPG Public Key ID: 455420ED
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.2 (GNU/Linux)
>
> iD4DBQE/O1V4Bn4EFUVUIO0RAu0VAJip/2qWkG6e6uc/YVYKD5u2f6RwAJ9msH9y
> y1VIT2ZaUL5dCQPGoRvjTg==
> =a21r
> -----END PGP SIGNATURE-----
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

