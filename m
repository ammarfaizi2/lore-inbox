Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129441AbRAWJTp>; Tue, 23 Jan 2001 04:19:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129446AbRAWJTi>; Tue, 23 Jan 2001 04:19:38 -0500
Received: from fs1.dekanat.physik.uni-tuebingen.de ([134.2.216.20]:27911 "EHLO
	fs1.dekanat.physik.uni-tuebingen.de") by vger.kernel.org with ESMTP
	id <S129441AbRAWJTS>; Tue, 23 Jan 2001 04:19:18 -0500
Date: Tue, 23 Jan 2001 10:18:36 +0100 (CET)
From: Richard Guenther <richard.guenther@student.uni-tuebingen.de>
To: Werner Almesberger <Werner.Almesberger@epfl.ch>
cc: Keith Owens <kaos@ocs.com.au>, David Luyer <david_luyer@pacific.net.au>,
        <alan@redhat.com>, Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: "Pass module parameters" to built-in drivers
In-Reply-To: <20010122165638.E4979@almesberger.net>
Message-ID: <Pine.LNX.4.30.0101231016020.491-100000@fs1.dekanat.physik.uni-tuebingen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Well, I did a very similar patch about 2.3.3x and it got even
included in -acXX during a Linus vacation - but it got dropped for
some reason (f.i. such an approach does not work well for multi-file
modules, I was told). I re-sent it during the 2.4.0-test phase and
got no reply, so I think just adding __setup() stuff manually to
every module seems the way to go... :(

Richard.

On Mon, 22 Jan 2001, Werner Almesberger wrote:

> Keith Owens wrote:
> > Inconsistent methods for setting the same parameter are bad.  I can and
> > will do this cleanly in 2.5.
>
> If your approach isn't overly intrusive (i.e. doesn't require changes
> to all files containing module parameters, or such), maybe you could
> make a patch for 2.4.x and wave it a little under Linus' nose. Maybe
> he likes the scent ;-)
>
> In any case, once it's in 2.5.x, and if it is as useful as I suspect
> it to be, it would probably be back-ported to 2.4 sooner or later.
>
> - Werner
>
> --
>   _________________________________________________________________________
>  / Werner Almesberger, ICA, EPFL, CH           Werner.Almesberger@epfl.ch /
> /_IN_N_032__Tel_+41_21_693_6621__Fax_+41_21_693_6610_____________________/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
>

--
Richard Guenther <richard.guenther@student.uni-tuebingen.de>
WWW: http://www.anatom.uni-tuebingen.de/~richi/
The GLAME Project: http://www.glame.de/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
