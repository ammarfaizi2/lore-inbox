Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131917AbQLHCAF>; Thu, 7 Dec 2000 21:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131916AbQLHB7r>; Thu, 7 Dec 2000 20:59:47 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:9732 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S131894AbQLHB7h>; Thu, 7 Dec 2000 20:59:37 -0500
Message-ID: <3A303852.790E3CE4@timpanogas.org>
Date: Thu, 07 Dec 2000 18:24:34 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Rainer Mager <rmager@vgkk.com>, linux-kernel@vger.kernel.org
Subject: Re: Signal 11
In-Reply-To: <E144BOL-0003Eg-00@the-village.bc.nu> <NEBBJBCAFMMNIHGDLFKGMEFHCIAA.rmager@vgkk.com> <20001208022044.A6417@gruyere.muc.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andi,

It's related to some change in 2.4 vs. 2.2.  There are other programs
affected other than X, SSH also get's spurious signal 11's now and again
with 2.4 and glibc <= 2.1 and it does not occur on 2.2.

Jeff

Andi Kleen wrote:
> 
> On Fri, Dec 08, 2000 at 09:44:29AM +0900, Rainer Mager wrote:
> >       I recently upgraded to a new machine. It is running RedHat 6.2 Linux (with
> > a SMP 2.4.0test[8-11] kernel) and has a Matrox G400 in it. X is 4.0.1.
> > Anyway, about once every 2-3 days X will spontaneously die and the only info
> > I get back is that it was because of signal 11.
> >       I've heard that signal 11 can be related to bad hardware, most often
> > memory, but I've done a good bit of testing on this and the system seems ok.
> > What I did was to run the VA Linux Cerberos(sp?) test for 15 hours+ with no
> > errors. Actually this only worked when running from the console. When
> > running from X the machine locked up (although no signal 11).
> >       The only info I've gotten back from the XFree86 mailing lists so far is
> > that there are known and wide spread problems with SMP and these types of
> > problems. Can anyone comment on this? Are there known SMP problems? What is
> > the current resolution plan?
> 
> signal 11 just means that the program crashed with a segmentation fault.
> 
> Sounds like a X Server bug. You should probably contact XFree86, not
> linux-kernel
> 
> -Andi
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
