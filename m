Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129188AbQKHQb1>; Wed, 8 Nov 2000 11:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129211AbQKHQbR>; Wed, 8 Nov 2000 11:31:17 -0500
Received: from slc1061.modem.xmission.com ([166.70.8.45]:26886 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S129188AbQKHQbE>; Wed, 8 Nov 2000 11:31:04 -0500
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Installing kernel 2.4
In-Reply-To: <200011081205.eA8C5ui27838@pincoya.inf.utfsm.cl>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 08 Nov 2000 08:29:59 -0700
In-Reply-To: Horst von Brand's message of "Wed, 08 Nov 2000 09:05:56 -0300"
Message-ID: <m1k8aeeb2g.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand <vonbrand@inf.utfsm.cl> writes:

> I'd prefer to be a guinea pig for one of 3 or 4 generic kernels distributed
> in binary than of one of the hundreds of possibilities of patching a kernel
> together at boot, plus the (presumamby rather complex and fragile)
> machinery to do so *before* the kernel is booted, thank you very much.
> 
> Plus I'm getting pissed off by how long a boot takes as it stands today...

Just for reference I can Boot from Power on to Login prompt in 12 seconds.
With Linux.  The big change is nuking the BIOS....

> > They just want it to boot, and run with the same level of ease of use
> > and stability they get with NT and NetWare and other stuff they are used
> > to.   This is an easy choice from where I'm sitting.
> 
> Easy: i386. Or i486 (I very much doubt your customers run on less, and this
> should be geneic enough).

It's also possible to do a two stage boot.  Stage 1 i386 kernel stage 2 the
specific kernel for the machine....  This adds about a second to the
whole boot process.

Eric

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
