Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129598AbQLHCSb>; Thu, 7 Dec 2000 21:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129627AbQLHCSW>; Thu, 7 Dec 2000 21:18:22 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:17668 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129598AbQLHCSL>; Thu, 7 Dec 2000 21:18:11 -0500
Message-ID: <3A303CAD.5600DE5A@timpanogas.org>
Date: Thu, 07 Dec 2000 18:43:09 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Rainer Mager <rmager@vgkk.com>, linux-kernel@vger.kernel.org
Subject: Re: Signal 11
In-Reply-To: <E144BOL-0003Eg-00@the-village.bc.nu> <NEBBJBCAFMMNIHGDLFKGMEFHCIAA.rmager@vgkk.com> <20001208022044.A6417@gruyere.muc.suse.de> <3A303852.790E3CE4@timpanogas.org> <20001208024018.A6673@gruyere.muc.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andi Kleen wrote:
> 
> On Thu, Dec 07, 2000 at 06:24:34PM -0700, Jeff V. Merkey wrote:
> >
> > Andi,
> >
> > It's related to some change in 2.4 vs. 2.2.  There are other programs
> > affected other than X, SSH also get's spurious signal 11's now and again
> > with 2.4 and glibc <= 2.1 and it does not occur on 2.2.
> 
> So have you enabled core dumps and actually looked at the core dumps
> of the programs using gdb to see where they crashed ?

Yes.  I can only get the SSH crash when I am running remotely from the
house over the internet, and it only shows then when running a build in
jobserver mode (parallel build).  The X problem seems related as well,
since it's related to (usually) NetScape spawing off a forked process. 
I will attempt to recreate tonight, and post the core dump file.  

Jeff 





> 
> -Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
