Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262812AbSI3SPT>; Mon, 30 Sep 2002 14:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262816AbSI3SPS>; Mon, 30 Sep 2002 14:15:18 -0400
Received: from niobium.golden.net ([199.166.210.90]:8674 "EHLO
	niobium.golden.net") by vger.kernel.org with ESMTP
	id <S262812AbSI3SPO>; Mon, 30 Sep 2002 14:15:14 -0400
Date: Mon, 30 Sep 2002 14:20:22 -0400
From: "John L. Males" <software_iq@hotmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: v2.6 vs v3.0
Message-Id: <20020930142022.592b020b.software_iq@hotmail.com>
Reply-To: software_iq@hotmail.com
Organization: Toronto, Ontario - Canada
X-Mailer: Sylpheed version 0.8.2-SrtRecipientSMTPAuthNDateSmartAcctSaveAllOpnNxtMsg (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.Qe.3tDg1lYO7a4"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.Qe.3tDg1lYO7a4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Linus,

***** Please BCC me in on any reply, not CC me.
Two reasons, I am not on the Mailing List,
and second I am suffering BIG time with SPAM
from posting to mailing lists/Newsgroups.
Instructions on real address at bottom.
Thanks in advance. *****

> From: Linus Torvalds
> Subject: Re: v2.6 vs v3.0
> Date: 	Sat, 28 Sep 2002 18:31:45 -0700 (PDT)
> 
> On Sat, 28 Sep 2002, Ingo Molnar wrote:
> > 
> > i consider the VM and IO improvements one of the most important
> > things that happened in the past 5 years - and it's definitely
> > something that users will notice. Finally we have a top-notch VM
> > and IO subsystem (in addition to the already world-class
> > networking subsystem) giving significant improvements both on the
> > desktop and the server - the jump from 2.4 to 2.5 is much larger
> > than from eg. 2.0 to 2.4.
> 
> Hey, _if_ people actually are universally happy with the VM in the
> current 2.5.x tree, I'll happily call the dang thing 5.0 or whatever
> (just kidding, but yeah, that would be a good enough reason to bump
> the major number).

Just a comment, I suggest the version should stay in the 2.x domain. 
Being called a 2.6 makes sense as it follows the established version
naming.  If there is a trend to do a version 2.42.x or 2.62.x I
suggest that the respective development versions would be 2.32.x and
2.52.x. 

> 
> However, I'll believe that when I see it. Usually people don't
> complain during a development kernel, because they think they
> shouldn't, and then when it becomes stable (ie when the version
> number changes) they are surprised that the behabviour didn't
> magically improve, and _then_ we get tons of complaints about how
> bad the VM is under their load.

The reason is simple why this happens.  People and organizations do
not have time to do such testing, let alone create a parallel test
system.  This means real and serious effort needs to be taken in
developing well focused test cases for the various elements of the
Kernel, run each RC and final of Kernel through these battery of
tests, then releae the Kernel RC for evaluation by the community to
find the type of bugs that cannot be found in formal QA/Testing due to
obvious nature of limited hardware combinations that can be tested. 
Point is, people can be really shy of testing something that is
"development" based and not been formally tested.  I know from first
hand experience, I have gone back to the 2.2.x kernel simply because
the 2.4.x kernel has had too many stability issues for my modest day
to day workstation use as much as I wanted some of the improvements in
the 2.4.x kernel.

Even when the Kernel is released as "production" level many sit on
fence to see what others experience and flush out.  This happens to
greater degree as there is no formal Kernel testing.  This has to
change.  It cannot be started overnight, but in steps it can and grow
to base.  I know there are projects and efforts to do formal Kernel
testing, but it needs to be part of the process and fully supported by
the community.  Otherwise the Kernel (the heart and soul of the
system) is just not taken as serious as fast as it should and deserves
from all the fine effort and talent that gives the Kernel its life.

> 
> Am I hapyy with current 2.5.x?  Sure. Are others? Apparently. But
> does that mean that we have a top-notch VM and we should bump the
> major number? I wish.
> 
> The block IO cleanups are important, and that was the major thing
> _I_ personally wanted from the 2.5.x tree when it was opened. I
> agree with you there. But I don't think they are
> major-number-material.

Agreeded.

> 
> Anyway, people who are having VM trouble with the current 2.5.x
> series, please _complain_, and tell what your workload is. Don't sit
> silent and make us think we're good to go.. And if Ingo is right,
> I'll do the 3.0.x thing.

Linus, I have not been able to get my system in state to do the
testing of the VM subsystem due mostly to other issues.  If there is
someone in Toronto that can allow me access to one system that has
both IDE and SCSI on it and at least 256MB of RAM I have lots of
special testing I can do on the VM subsystem.  CPU wise it would be
good to have a uniprocessor as well as SMP system, where CPU is at
least in the 400Mz or above range.  I reatehr have a slower level CPU
system that too fast.  If both a fast and slow CPU system can be made
available that is great.  If only SMP system can be provided or meets
other requirements, that is ok, I will just disable SMP and compile a
kernels without SMP to do tests.  Do not think this is all a strange
and trivial request, as there are several combination even in the very
very basic sense that should be done.  If the system can have more RAM
to validate the corner that seems to exist with larger memory
configurations that would be great.  It would be most helpful to have
a tape backup to allow easy save and restore of test images without
having to rebuild them each time.  A capacity of at least 4 MB
uncompressed per tape would be most helpful.  A DVD writer would be an
ok alternative to tape.

I am not fussy what is availavle as backup as long as it does job, so
long as there is one and not hard drive based.  Some of this testing
could uncover some file system issues at stress levels based on past
experience.  I therefore need backups to be able to shorten time to
restore and retest for any issues found and also to always start with
"exact" same reference point in case there is an additive element of
bugs to the testing that will distort the testing.

A native network connection of at least 10 mbits to allow FTP installs
would be most helpful, as well as a CDWriter.

I have created various programs and test cases, but still need to
refine them in terms of making them more automated.  For not I can
easily create a number of test cases, but has much duplicate effort on
coding until I can distill the elements and then ayutomate many of the
elements.  I honestly believe what I have developed more effectively
isolates the VM subsystem so that other kernel functions and demands
do not cloud the ability to evaluate a VM subsystem.

The tests I would conduct would at a minimum test and compare the VM
behaviour of Linux Kernel versions 2.2.22, 2.4.18, 2.4.19, 2.4.20,
current 2.5.x, FreeBSD 4.6, 4.6.2, 4.5.  All the Linux versions would
be compiled done on the same base distribution and configuration. 
Side effects of VM testing would require more variables to be tested
in combination to ensure no ill effects of system VM stress affect the
other elements of the Kernel, i.e. to ensure Web Servers, Database
servers, etc can be stable under peak stress conditions with respect
to file systems and no accumulating loss of system performance as
function of time and system stress. 
 
> 
> 		Linus

Regards,

John L. Males
Software I.Q. Consulting
Toronto, Ontario
Canada
30 September 2002 14:20


==================================================================


According to Steve McConnell in:
After the Gold Rush: Creating a True Profession of
Software Engineering
About 50% of the current software engineering body of knowledge
is stable and will still be relevant 30 years from now.


***** Please BCC me in on any reply, not CC me.
Two reasons, I am not on the Mailing List,
and second I am suffering BIG time with SPAM
from posting to mailing lists/Newsgroups.
Instructions on real address at bottom.
Thanks in advance. *****


Please BCC me by replacing after the "@" as follows:
TLD =         The last three letters of the word "internet"
Domain name = The first three letters of the word "theory",
              followed by the first three letters of the word
              "offsite", followed by the first three letters
              of the country "Iceland".
My appologies in advance for the jumbled eMail address
and request to BCC me, but SPAM has become a very serious
problem.  The eMail address in my header information is
not a valid eMail address for me.  I needed to use a valid
domain due to ISP SMTP screen rules.

Please note: You may experience delays in my replies.  I will
             reply.

             This is due to major restoration activity to my riser
             section of the building.

             My internet access will be limited to a couple weekday
             evenings.  Weekend access will be a bit better but
             limited as an indirect consequence of the restoration
             work.

             If for any reason you need a more immediate reply or
             fail to receive a reply, please phone and leave a
             message.  If you do leave a phone message, please note
             that I may not be able to hear the message and/or
             reply until the evening.  This will be due to the
             extensive noise levels of the restoration work
             activity drowning out most other volume levels of
             sound.

             The work starts 22 July 2002.  Based on similar
             experience to other sections of the building I would
             estimate the major noise element of the work to be
             about 4+ weeks for my riser.  There will be secondary
             instances once other ajacent riser sections are done
             that will have a similar impact, but for lessor
             periods of time.

             My appologies in advance, but this is mandated work
             that must be done.

--=.Qe.3tDg1lYO7a4
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iEYEARECAAYFAj2YlfIACgkQSeCOqZntNWW1BwCfUE+i4H5RSvZ54xvhIUjIY0z1
hFAAoJTnBKDdiP1enS4TsEpuX8jFSw79
=YHHU
-----END PGP SIGNATURE-----

--=.Qe.3tDg1lYO7a4--
