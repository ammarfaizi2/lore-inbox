Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268100AbRHMUaj>; Mon, 13 Aug 2001 16:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268145AbRHMUac>; Mon, 13 Aug 2001 16:30:32 -0400
Received: from postfix1-2.free.fr ([213.228.0.130]:36110 "HELO
	postfix1-2.free.fr") by vger.kernel.org with SMTP
	id <S268071AbRHMUaV> convert rfc822-to-8bit; Mon, 13 Aug 2001 16:30:21 -0400
Date: Mon, 13 Aug 2001 22:27:46 +0200 (CEST)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: PinkFreud <pf-kernel@mirkwood.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Are we going too fast?
In-Reply-To: <Pine.LNX.4.20.0108131249190.1037-100000@eriador.mirkwood.net>
Message-ID: <20010813214312.Q1103-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 13 Aug 2001, PinkFreud wrote:

> > On Mon, 13 Aug 2001, PinkFreud wrote:
> >

[...]

> > About ncr53c8xx problem reports, I cannot reply to all of them. You may
> > also send them to LSILOGIC support. They also want Linux to work with the
> > ncr/sym/lsi/53c8xx PCI-SCSI controllers, even with old NCR ones. Some
> > other vendors seem to just ignore old hardwares. For example NVIDIA that
> > killed (bought?) 3DFX, does not seem interested in maintaining drivers for
> > the 3DFX graphic chips.
>
> Have a contact address for LSILOGIC?  I'll be happy to CC them in any
> future bug reports.  It may also be useful to place this address in
> comments at the top of the ncr53c8xx driver as well.

It is in fact Pamela Delaney, a LSILOGIC employee, who added support for
the 53C1010 in the sym53c8xx driver version 1.6. This allowed me time for
porting version 1.5 (without C1010 support) to FreeBSD (sym driver) and to
add my own variant of C1010 support to sym. Pamela didn't seem to want to
add her name and address in the source.  Anyway, you may want to have a
look at the LSILOGIC web and ftp site for the Linux support. I would be
surprised if you cannot find Pamela's email address.

> > I use Linux since some 0.99.x (was yygdrasil distribution). My experience
> > has been that 1.2.13, 2.0.27 and 2.2.13 worked reliable enough for me.
>
> I've used all three of those kernels, and I tend to agree - except for the
> nasty security hole in 2.2.13 (but that happens with any OS - look at
> Windows!).
>
> > 'Stable' does not means reliable for any workload. It means that we stop
> > developping (implies changing large portions of code or modifying
> > interfaces) but only focus on fixing the software with it current design
> > (implies only changing what is proven to be broken).  This applies to all
>
> I think I've proven a number of things to be broken in the 2.4.x series -
> but they doesn't seem to be getting fixed.  My point was, perhaps more
> effort should be put into fixing these bugs, rather than adding new
> features to a supposedly stable series.

Matter of opinion. I would say that Linux-2.4 has been way long to come
and wasn't quite ready for stable status. There are numerous other O/Ses
that have had to suffer such a problem in their long life, especially
commercial ones. Nothing that only applies to Linux here, in my
experience.

> > softwares, not only to Linux. As a result, early stable releases still
> > have numerous bugs that may prevent numerous systems from working
> > reliably. It is up to user to check releases and switch to the one that
> > fits his expectations.
>
> If Linux is trying to prove itself usable for the business world, how is
> that going to help?  I'm not implying that I'm a business in any way,
> shape, or form - but given that I think the majority of us want to see
> Linux in the server rooms, and even on the desktop, what does this mean
> for those users?

Btw, we are using some Linux machines at the company I work to. They
donnot seem to run 2.4 kernels for the moment. As I am the only guy that
also uses FreeBSD, I donnot want to risk FreeBSD 5 for real work for the
same reason. :)
OTOH, we have software that explodes Solaris 8 in a millisecond but that
works reliably on previous Solaris releases, but Solaris 8 is not that
young an OS release as we know. Just an example that applies to a
commercial Unix O/S...

> > > This brings me to the subject of this rant: are we going too fast?  New
> > > drivers are still showing up in each successive kernel, and yet no one
> > > seems to be able to fix the old bugs that already exist.  Are we looking
> > > to have the reliability of Windows?  It's starting to seem so - each
> > > successive kernel series just seems to crash more and more often.  When
> > > will we reach the point where Windows, on the average, will have greater
> > > uptime than Linux systems?  Perhaps it's time to slow down, and do some
> > > debugging.
> >
> > The reliabity of Windows seems to be just fine for most users since it is
> > the O/S most of them want to use.:-)
>
> I know plenty of Windows users who are quite upset at the lack of
> stability.  They either don't know/understand that there are alternatives,
> or feel it's too hard to switch to an alternative.

A windows machine is generally some melting pot of [an O/S + broken
hardwares + broken drivers + broken applications + viruses] driven by
unaware users. It is a miracle for such a thing to work enough for real
work to be possible. Personnaly, I haven't problems with Windows. It runs
games just fine and since I donnot use it for anything else, it just fit
my needs. :-)

> > > Should development continue on the latest and supposedly greatest
> > > drivers?  Or should the existing bugs be fixed first?  I've got at least
> > > three up there that need taking care of, and I'm sure others on this list
> > > have found more.  3 seperate crashes on 3 seperate installs on 3 seperate
> > > boxes - that's 100% failure rate.  If I get 100% failure on my installs,
> > > what are others seeing?
> >
> > Hopefully you aren't a typical computer user or you just have bad luck
> > with computers. :-)
>
> Certainly the case with the former, and sadly, you're not the first to
> suggest the latter.  :)
>
> > All software developpers and maintainers want their software to work and
> > thus bugs to be fixed. This is just sometimes hard to know what is
> > actually broken. My experience is that no more than 10% bug reports about
> > a software are due to a bug in the software that is pointed out by the
> > report. And for these less than 10% relevant reports, maintainers must
> > find what is broken... not simple as you can imagine...
>
> I definintely believe this (the random panic) to be a bug in your
> ncr53c8xx driver.  ksymoops seemed to believe it to be the case, and
> NetBSD seems to be working fine, which means it's not faulty hardware.

I have retrieved your bug report (emailed on 28 July 2001). I was in
vacation at this date until yesterday. I cannot read thousands of emails
in a couple of hours, sorry.

The problem is due to a NULL pointer being read from the driver DONE
queue. This queue uses 0xfffffff as a tag for empty entries and valid
addresses for entries pointing to completed CCBs. Since this driver is
actually stable since years (only sym53c8xx was under development) it is
likely the driver data structures that are screwed up from some other
place rather than a driver bug, in my opinion. If this also happens on
2.2.x (x>=18) kernel release, it will be another story, obviously.

[...]

Regards,
  Gérard.

