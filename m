Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313910AbSDJWRw>; Wed, 10 Apr 2002 18:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313911AbSDJWRv>; Wed, 10 Apr 2002 18:17:51 -0400
Received: from rtlab.med.cornell.edu ([140.251.145.175]:26800 "HELO
	openlab.rtlab.org") by vger.kernel.org with SMTP id <S313910AbSDJWRu>;
	Wed, 10 Apr 2002 18:17:50 -0400
Date: Wed, 10 Apr 2002 18:17:50 -0400 (EDT)
From: "Calin A. Culianu" <calin@ajvar.org>
X-X-Sender: <calin@rtlab.med.cornell.edu>
To: Steven Cole <elenstev@mesatop.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Cannot compile mandrake 8.2 Kernel
In-Reply-To: <1018475564.17571.10.camel@spc.esa.lanl.gov>
Message-ID: <Pine.LNX.4.33L2.0204101814510.6362-100000@rtlab.med.cornell.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You are absolutely right.  I could have sworn i did a make mrproper && cp
/tmp/config .config && make oldconfig, but I may have missed the oldconfig
part. :/ I feel like such a n00b all of a sudden.  At any rate, thanks
sooo much for taking the time to troubleshoot this for me.  I managed to
build it finally, after meticulously doing the make mrproper and make
oldconfig as you reminded me I should..... :)

Thanks!

-Calin

> >
[other errors snipped] >
> I was able to reproduce this, but then I remembered Jeff Garzik's advice
> to always do a make mrproper (that applied to Alan's trees) when you see
> this kind of thing.  So, I saved the Mandrake supplied .config somewhere
> safe, did a make mrproper, copied the .config back, did make oldconfig,
> make dep, make -j3 bzImage (dual PIII machine), and make modules.  The
> first time, without the make mrproper, the failure occurred almost
> immediately, and now make modules has been cranking away for quite a
> while, so it should be OK.  Good luck.
>
> Steven
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

