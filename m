Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129454AbQKHRds>; Wed, 8 Nov 2000 12:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129459AbQKHRdi>; Wed, 8 Nov 2000 12:33:38 -0500
Received: from mail-04-real.cdsnet.net ([63.163.68.109]:53514 "HELO
	mail-04-real.cdsnet.net") by vger.kernel.org with SMTP
	id <S129454AbQKHRdU>; Wed, 8 Nov 2000 12:33:20 -0500
Message-ID: <3A098F11.1B89EB7B@mvista.com>
Date: Wed, 08 Nov 2000 09:36:17 -0800
From: George Anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.14-VPN i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "James A. Sutherland" <jas88@cam.ac.uk>
CC: Horst von Brand <vonbrand@inf.utfsm.cl>,
        "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Installing kernel 2.4
In-Reply-To: <200011081205.eA8C5ui27838@pincoya.inf.utfsm.cl> <00110816543500.01639@dax.joh.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

But, here the customer did run the configure code (he said he did not
change anything).  Isn't this where the machine should be diagnosed and
the right options chosen?  Need a way to say it is a cross build, but
that shouldn't be too hard.

My $.02 worth.

George


"James A. Sutherland" wrote:
> 
> On Wed, 08 Nov 2000, Horst von Brand wrote:
> > "Jeff V. Merkey" <jmerkey@vger.timpanogas.org> said:
> >
> > [...]
> >
> > > Your way out in the weeds.  What started this thread was a customer who
> > > ended up loading the wrong arch on a system and hanging.  I have to
> > > post a kernel RPM for our release, and it's onerous to make customers
> > > recompile kernels all the time and be guinea pigs for arch ports.
> >
> > I'd prefer to be a guinea pig for one of 3 or 4 generic kernels distributed
> > in binary than of one of the hundreds of possibilities of patching a kernel
> > together at boot, plus the (presumamby rather complex and fragile)
> > machinery to do so *before* the kernel is booted, thank you very much.
> 
> Hmm... some mechanism for selecting the appropriate *module* might be nice,
> after boot...
> 
> > Plus I'm getting pissed off by how long a boot takes as it stands today...
> 
> Yep: slowing down boottimes is not an attractive idea.
> 
> > > They just want it to boot, and run with the same level of ease of use
> > > and stability they get with NT and NetWare and other stuff they are used
> > > to.   This is an easy choice from where I'm sitting.
> >
> > Easy: i386. Or i486 (I very much doubt your customers run on less, and this
> > should be geneic enough).
> 
> I think there are better options. Jeff could, for example, *optimise* for
> Pentium II/III, without using PII specific instructions, in the main kernel,
> then have multiple target binaries for modules.
> 
> James.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
