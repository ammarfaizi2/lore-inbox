Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130694AbQKHDp6>; Tue, 7 Nov 2000 22:45:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130685AbQKHDps>; Tue, 7 Nov 2000 22:45:48 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:3336 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129544AbQKHDpm>; Tue, 7 Nov 2000 22:45:42 -0500
Date: Tue, 7 Nov 2000 21:41:47 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: davej@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: Installing kernel 2.4
Message-ID: <20001107214147.B8542@vger.timpanogas.org>
In-Reply-To: <3A0899EC.BCF17E69@timpanogas.org> <Pine.LNX.4.21.0011080332330.8632-100000@neo.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.21.0011080332330.8632-100000@neo.local>; from davej@suse.de on Wed, Nov 08, 2000 at 03:39:39AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2000 at 03:39:39AM +0000, davej@suse.de wrote:
> On Tue, 7 Nov 2000, Jeff V. Merkey wrote:
> 
> > > remember it's not just the start of the file that varies based on cachline
> > > size, it's the positioning of code and data thoughout the kernel image.
> > Understood.  I will go off and give some thought and study and respond
> > later after I have a proposal on the best way to do this.   In NetWare,
> > we had indirections in the code all over the place.  NT just make huge
> > and fat programs (NTKRNLOS.DLL is absolutely huge).
> 
> I'm glad you realise this.  The Netware method you mention above sounds
> over complicated for the desired end result, and the NT method just sounds
> like a gross hack.
> 
> The current 'compile for the arch you intend to run on' is right now,
> the simplest, cleanest way to do this.
> 
> If you manage to pull something off in MANOS or whatever other OS,
> to prove all this otherwise (without resorting to ugly hacks like the
> above), great for you, I (and I assume others) would like to hear
> about it.

Your way out in the weeds.  What started this thread was a customer who
ended up loading the wrong arch on a system and hanging.  I have to
post a kernel RPM for our release, and it's onerous to make customers
recompile kernels all the time and be guinea pigs for arch ports.  
They just want it to boot, and run with the same level of ease of use
and stability they get with NT and NetWare and other stuff they are used
to.   This is an easy choice from where I'm sitting.

Jeff  
 
> Davej.
> 
> -- 
> | Dave Jones <davej@suse.de>  http://www.suse.de/~davej
> | SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
