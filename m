Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129026AbRBGFu2>; Wed, 7 Feb 2001 00:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129028AbRBGFuT>; Wed, 7 Feb 2001 00:50:19 -0500
Received: from assigned.162.54.206.in-addr.arpa ([206.54.162.175]:24654 "EHLO
	mail.roland.net") by vger.kernel.org with ESMTP id <S129026AbRBGFuH>;
	Wed, 7 Feb 2001 00:50:07 -0500
Date: Tue, 6 Feb 2001 23:50:16 -0600 (CST)
From: Jim Roland <jroland@roland.net>
To: "J. Dow" <jdow@earthlink.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: RedHat kernel RPM 2.2.16
In-Reply-To: <0b2801c090c6$3e1a76e0$0a25a8c0@wizardess.wiz>
Message-ID: <Pine.LNX.4.05.10102062344490.31995-100000@ns.roland.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I appreciate your comments, but the SOURCE is exactly what I am needing in
order to compile in PCTel modem support.  FYI, I'm not a newbie, so I do
not uninstall a kernel from a running system (no offense on your
assumption :-P).  Besides if I did, I would just simply spend 5 minutes
creating a rescue floppy and away I go.  No problem.  Anyway, I have
already installed the binary form of the 2.2.16 kernel, I am needing the
sources so I can kludge together a module for the PCTel support.

FWIW, the rpm -i did unpack the kernel to the /usr/src/redhat/SOURCES
directory, however, I had to manually untar the sources to /usr/src to get
my kernel, move over the appropriate .config file, and manually run the
patches to patch the sources.  Forcing RPM to be very talkative (via -vv)
gave me a bunch of "action unknown" errors, and the rpm's install scripts
did not execute.  This occurs on an RH7 system as well.  Seems to be
something wrong with RH's kernel rpm?

JR



On Tue, 6 Feb 2001, J. Dow wrote:

> RTFM - it is writ large on the RedHat site. You have probably rendered your
> machine unbootable at this point if you tried first with the regular kernel
> RPM. Recovery is awkward. You *NEVER* *EVER* -U a kernel RPM. You *ALWAYS* -i
> it instead. Then your old kernel is still present in case the new one shows
> problems, like 2.2.16 will.
> 
> Furthermore installing the source RPMs does not install a new kernel. You have
> to proceed from there with building the kernel. That means you have to have
> kgcc installed and all the other proper materials.
> 
> I saw your email on the RedHat list but it was at the beginning of 80 some
> messages so I didn't reply figuring someone else would have. I guess nobody
> felt like typing "RTFM". As I say, RedHat has kernel compilation and kernel
> installation information on their website in a fairly easy to find place.
> A little digging would be good for your soul and education. There is other
> stuff there associated with the kernel compile and install instructions
> that can be a great help.
> 
> {^_^}
> 
> ----- Original Message ----- 
> From: "Jim Roland" <jroland@roland.net>
> To: <linux-kernel@vger.kernel.org>
> Sent: Tuesday, February 06, 2001 21:03
> Subject: RedHat kernel RPM 2.2.16
> 
> 
> > I am trying to get RedHat's Kernel RPM 2.2.16 installed, however, the rpm
> > program does unpack the files, but does not run any script to install them
> > into the source tree (kernel-2.2.16-3.i386.src.rpm).  Is there a trick to
> > making it work?
> > 
> > 
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > Please read the FAQ at http://www.tux.org/lkml/
> > 
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
