Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129326AbQKHQ4W>; Wed, 8 Nov 2000 11:56:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129286AbQKHQ4M>; Wed, 8 Nov 2000 11:56:12 -0500
Received: from lilac.csi.cam.ac.uk ([131.111.8.44]:46732 "EHLO
	lilac.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S129109AbQKHQz6>; Wed, 8 Nov 2000 11:55:58 -0500
From: "James A. Sutherland" <jas88@cam.ac.uk>
To: Horst von Brand <vonbrand@inf.utfsm.cl>,
        "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Subject: Re: Installing kernel 2.4
Date: Wed, 8 Nov 2000 16:51:24 +0000
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200011081205.eA8C5ui27838@pincoya.inf.utfsm.cl>
In-Reply-To: <200011081205.eA8C5ui27838@pincoya.inf.utfsm.cl>
MIME-Version: 1.0
Message-Id: <00110816543500.01639@dax.joh.cam.ac.uk>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Nov 2000, Horst von Brand wrote:
> "Jeff V. Merkey" <jmerkey@vger.timpanogas.org> said:
> 
> [...]
> 
> > Your way out in the weeds.  What started this thread was a customer who
> > ended up loading the wrong arch on a system and hanging.  I have to
> > post a kernel RPM for our release, and it's onerous to make customers
> > recompile kernels all the time and be guinea pigs for arch ports.  
> 
> I'd prefer to be a guinea pig for one of 3 or 4 generic kernels distributed
> in binary than of one of the hundreds of possibilities of patching a kernel
> together at boot, plus the (presumamby rather complex and fragile)
> machinery to do so *before* the kernel is booted, thank you very much.

Hmm... some mechanism for selecting the appropriate *module* might be nice,
after boot...

> Plus I'm getting pissed off by how long a boot takes as it stands today...

Yep: slowing down boottimes is not an attractive idea.

> > They just want it to boot, and run with the same level of ease of use
> > and stability they get with NT and NetWare and other stuff they are used
> > to.   This is an easy choice from where I'm sitting.
> 
> Easy: i386. Or i486 (I very much doubt your customers run on less, and this
> should be geneic enough).

I think there are better options. Jeff could, for example, *optimise* for
Pentium II/III, without using PII specific instructions, in the main kernel,
then have multiple target binaries for modules.


James.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
