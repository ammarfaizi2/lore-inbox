Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129361AbQK0S03>; Mon, 27 Nov 2000 13:26:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129593AbQK0S0T>; Mon, 27 Nov 2000 13:26:19 -0500
Received: from office.mandrakesoft.com ([195.68.114.34]:17913 "HELO
        matrix.mandrakesoft.com") by vger.kernel.org with SMTP
        id <S129361AbQK0S0I>; Mon, 27 Nov 2000 13:26:08 -0500
To: "H. Peter Anvin" <hpa@transmeta.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Mandrake Install <install@linux-mandrake.com>
Subject: Re: Universal debug macros.
In-Reply-To: <200011270045.BAA13121@cave.bitwizard.nl>
        <Pine.LNX.4.10.10011270302570.24716-100000@yle-server.ylenurme.sise>
        <8vsno2$pc6$1@cesium.transmeta.com>
        <m3vgt9nykk.fsf@matrix.mandrakesoft.com>
        <3A229E41.B3C278E2@transmeta.com>
From: Chmouel Boudjnah <chmouel@mandrakesoft.com>
Date: 27 Nov 2000 18:56:05 +0100
In-Reply-To: <3A229E41.B3C278E2@transmeta.com>
Message-ID: <m3aealnvt6.fsf@matrix.mandrakesoft.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@transmeta.com> writes:

> > > Something RedHat & co may want to consider doing is providing a basic
> > > kernel and have, as part of the install procedure or later, an
> > > automatic recompile and install kernel procedure.  It could be
> > > automated very easily, and on all but the very slowest of machines, it
> > > really doesn't take that long.
> > 
> > this completely not possible to do in regard of the end-users eyes.
> > 
> 
> Why not?

slow !! end-user want to install a distribution fast !!! 

it need a lot to be friendly the compilation (ie: we cannot do only
launch of make xconfig, not everyone now which options to select),
what we can do is a detection of the module and recompile a kernel
with the detected module for recompilation but there is too much error
case that could not be handle.

-- 
MandrakeSoft Inc                     http://www.chmouel.org
                      --Chmouel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
