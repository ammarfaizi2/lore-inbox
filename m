Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288748AbSA3H3w>; Wed, 30 Jan 2002 02:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288752AbSA3H3o>; Wed, 30 Jan 2002 02:29:44 -0500
Received: from sodium.golden.net ([199.166.210.252]:26073 "EHLO
	sodium.golden.net") by vger.kernel.org with ESMTP
	id <S288748AbSA3H3f>; Wed, 30 Jan 2002 02:29:35 -0500
From: "John L. Males" <software_iq@TheOffice.net>
Organization: Toronto, Ontario, Canada
To: linux-kernel@vger.kernel.org
Date: Wed, 30 Jan 2002 02:29:29 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: A modest proposal -- We need a patch penguin
Reply-to: software_iq@TheOffice.net
Message-ID: <3C575A89.12030.2A9A53B@localhost>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

***** I am not on the Kernel Mailing list.  I would appreciate any
replies or references made to this eMail copy me in as well *****

***** My hope is this eMail will become part of the current thread
that was started with Rob Landley's initial eMail of 28 January 2002
*****

Ok, now to the meat of the matter.  I what has been proposed and the
discussion thereafter has had many opinions and thoughts.  I have not
had a chance to read all of the responses and comments, but have read
a number of them to develop a sense of what has been proposed, why it
was proposed and the pros and cons related to same.

First seeing as I am not a familar "face" in this mailing list or to
the community I want give a simple introduction to myself that I
think is very important.  I am a Career QA/Testing person.  For any
that may have any notion about my understanding of operating systems,
compilers, etc, suffice to say my early days involved heavy
modification to an IBM operating system by disassembling it back from
source binary cards and then making the modifications to the
"operating system", compilers, assembles, linker, librarian.  Many of
these very major changes to the OS.  This was before software had
copyright.  Ok I am dating myself.  I also wrote a replacement system
generation/load from scratch/bootstrap of a virgin system as well as
the supporting programs to produce the realted OS files, compilers,
support utilities.  This is not to upstage any developer or kernel
"hacker".  I lay this background information so all know I have an
appreciation of what is involved in maintaing an OS kernel agmonst
other things.

Without any intent to offend any member of the community I want to
note my comments are with a number of years experience related
QA/Testing and Change Control/Management.  I mentioned the above as
what I did not elude to was how this actually was the foundation of
my strong QA/Testing skills.

Ok, lets get to the meat of the matter.  Please bear with me as I
want to simplify what the proposal is about, the objections,
challenges and some of the enhanced suggestions.

Firstly with all due respect to Linus' view, there is a problem here.
 The proposal is a concerned attempt to address some of the problems
and/or formalize the unofficial practices that have been ongoing.

The basic essence of the issue at hand is the number of patches for
any number of reasons not making it into the main kernel tree as
maintained by Linus.  I appreciate some of the pros and cons why this
is as supported in the proposal and in Linus' comments.  I am also
aware of Linus perspective of allowing small forks of the kernel to
allow time and milage to determine how good a feature and/or
implementation is before accepting it into his kernel tree.

What concerns me is there are just too many kernel varients not just
via the Kernel Developer community, but also factoring in the various
distribution kernel varients.  In the kernel community we have not
just different trees, but a whole bunch of patches.  Many seem to
have very good merit.

The core issues with the pile of patches/varients is two fold.  One
not having a central source point to store the patches.  The second
the ability to have a single; choose (i.e. as would be case for VM
work); tree of a "bleeding edge" kernel.  It appears to me much time
is being wasted in trying to get patches accepted on a repeated basis
for a given patch, if it is accepted at all.

What we have despite the suggestion otherwise is a very forked
kernel.  In my humble opinion the matter is already out of control. 
I talk from experience and first hand coping with forked code.  A
development team I know of did fork the code initially due to
problems and time issues to get fixes or enhancements out to clients
in a shorter time.  The "collective" would not work or required much
more effort to work and time seemed not to permit development to do
so.  Does this sound familar, but different driving reasons why this
condition happens for the Kernel?  Suffice to say the matter was on
the same scale as the Kernel, just instead of many parties being
involved such as hackers and distributions in the Linux Kernel case,
it was done by the same company development teams for "business"
reasons to acheive a shorter deliverly of working code to customers.

The essence was the code continued to fork many more times with
several subset varients for each release and from release to release
some fixes/features were not available in each release.  Matters
finially became a support nightmare, and then problems where
customers needed certain fixes or features only for support to find
out some or all of the needs of the customers were mutually exclusive
- - In other words the "collective" had all of them, but implemented at
different patch or version levels.  In my humble opinion the Linux
kernel is close to that point right now.  The company development
teams finailly had to wake up to fact this temporary forking approach
could not longer meet customer needs and more importanly was becoming
a developmet nightmare in managing the code base.  The result was the
company had to put fixes on hold for several months as they tried to
merge the code base back to a single version.  The finial result was
a working finial single version, but at a extremely high cost, not
just in dollars, but in manpower and development effort to bring
things all back into line.

I will not go into the second example, but I have seen this happen
again.  With the same problems and issues, except it was a release
catch up issue and a "merge Master" person dedicated as the primary
developer to bring things back in line between the two product
versions.

It is my considered opinion the Linux kernel is a much larger code
base and level of complexity then either of the obove noted two
examples.  I see the writing on the wall.  Everyone agrees of the key
role Linus has as being the Architect and one who brings a wholeness
to the code standards, interfaces, etc of the Linux Kernel.  As I see
things now, that is slowly starting to slip and erode.  All one has
to do is look at how many Kernel tree varients exist.  Linus himself
may not be conerned, but I am and I think many people are.

I would ask that the community pause for moment and really think
about what is at state here, and if the real risk is worth taking?  I
for one hold the opinion it is not.

The Kernel has grown and it is time to adopt some formal processes
and open discussion to how best to implement those processes.  It is
simply necessary given how popular and important the Linux Kernel has
become and it is also part of the growth process of the Linux Kernel.
 Failing to accept the growth and further maturing of the Linux
Kernel will need to change some of the practices that were managable
when the Linux Kernel was a software "kid" or "early teenager" I am
afraid may end up resulting in its demise or the important guidance
of the "core" Linux team to the code and direction.

I have other thoughts and appreciate there have been arguments
presented for and against the proposal both in public and privately
between various people.  The first and most important step is to
first accept this need to accept it is time to take the approach of a
"staging" tree for all patches.  Once that is accepted, then the next
phase can be to determine how best to approach the challenge.  It
will be a challenge, but the community is so large and diverse I
believe it can accomplish the challenge.  What is important is to
focus on the issue at hand and try to keep a focus on that rather
than the side or down the road issues.  Like development of code, it
is an incremental and progressive itteration process.  This issue is
not different and can be acheived using the same process of thought,
design, debugging and implementation as all good code evolves from.

Thank you for your time and patience in reading my comments and
thoughts.  I hope in reflection and consideration of my background as
a prior assemble programmer, OS/Compiler/System person and my
QA/Testing experience that the community can understand why Rob
Landley's proposal was made and important to the Linux community at
large.


Regards,

John L. Males
Software I.Q. Consulting
Toronto, Ontario
Canada
30 January 2002 02:29
mailto:software_iq@TheOffice.net

-----BEGIN PGP SIGNATURE-----
Version: PGPfreeware 6.5.8 for non-commercial use <http://www.pgp.com>
Comment: .

iQA/AwUBPFeg1PLzhJbmoDZ+EQJ+0wCghl7QBBKthhAb7aOPDMW9gbb/C+cAoLzE
9SodkZaQXNWNIg3aNBUyAiSE
=sluA
-----END PGP SIGNATURE-----



"What is your goal? Is it to reduce testing, or to reduce risk? Where is the greatest return?"
Linda Hayes is CEO of WorkSoft Inc. She was one of the founders of AutoTester.
>From article "Does Test Automation Save Time?", May 9, 2001 - IT Management
