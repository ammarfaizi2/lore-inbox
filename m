Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315388AbSFUW7V>; Fri, 21 Jun 2002 18:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315943AbSFUW7U>; Fri, 21 Jun 2002 18:59:20 -0400
Received: from niobium.golden.net ([199.166.210.90]:38369 "EHLO
	niobium.golden.net") by vger.kernel.org with ESMTP
	id <S315388AbSFUW7T>; Fri, 21 Jun 2002 18:59:19 -0400
Date: Fri, 21 Jun 2002 18:58:06 -0400
From: "John L. Males" <software_iq@hotmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.2 and 2.4 performance issues
Message-Id: <20020621185806.06011dd1.software_iq@hotmail.com>
Reply-To: software_iq@hotmail.com
Organization: Toronto, Ontario - Canada
X-Mailer: Sylpheed version 0.7.8 (GTK+ 1.2.10; i586-pc-linux-gnu-Patched-SortRecipient-CustomSMTPAuthNDate)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.hB40j7GXc1X7II"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.hB40j7GXc1X7II
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello,

***** Please BCC me in on any reply, not CC me.
Two reasons, I am not on the Mailing List,
and second I am suffering BIG time with SPAM
from posting to mailing lists/Newsgroups.
Instructions on real address at bottom.
Thanks in advance. *****


>From:     Nathan Straz <nstraz@sgi.com>
>Date:     2002-06-21 17:10:59
>[Download message RAW]
>
>On Fri, Jun 21, 2002 at 05:55:55PM +0100, Luis Pedro de Moura Ribeiro
>Pinto wrote:> I was asked (i'm a company freshman) to perform some
>tests between> kernel versions 2.2 and 2.4, and after awhile
>searching i found a good> set of benchmarking tools (aim7) from
>Caldera linux. 

One needs to first determine what is required to be tested.  That
implies understanding the conditions that to be tested, the realted
metric information known to affect the test conditions, and what
metric and criteria information is needed to evaluate the results. 
Blinding testing no matter how good the tool may or may not be is
inappropriate.  One first needs to determine what are the evaluation
criteria, then find the tools and/or create the tests to match the
criteria to be evaluated. "Good" is a relative term.  What is good,
excellent or inappropriate for one test case may be quite different
for another.

>
>Benchmarks are evil.  Sure they are useful at times, but for the most
>part they get misused.  IMHO, aim7 is outdated.  The I/O it does it
>all

The statement that benchmarks are "evil" is meaningless.  I will grant
you that many people have no idea and/or have no understand of what a
"benchmark" test is testing, the scope of its test or what the
implications of the results man mean.  So what happens is benchmarks
are often abused, translation - misunderstood.  Benchmarks are useful,
and most useful, if proper care in determining the necessary
conditions that need to be tested are in fact matched to what the
benchmark will be testing, their assumptions and what is not tested or
mutually exclusive to the conditions of the test are.

>very small for today's systems.  It's like poking the system with
>hundreds of needles.  You have no idea how the system will react to a
>golf club, baseball bat, sledgehammer or a wet noodle.  Sure, some

Such a test is valid for what it is testing.  There are two questions
this point begs.  One was the test conducted reflective of what the
user will be doing?  No point testing a 747's ability to go to the
moon if that is not what you will use the 747 for!  Second, such a
test condition has value.  The value is not only in what the test may
indicate on actual behavioural results.  There are test cases that
perhaps may not be as "real" world in general sense, but the nature of
the test can focus so well on isolated elements.  Such a narrow focus
helps in finding what may indicate a problem that otherwise has eluded
more "real" world type testing.

>people really like it and swear by it.  Benchmarking is better done
>with an application set in mind and best done with the application
>set itself. 

The problem with the term "benchmarking" is depending on the user it
can mean one of a variety of things, such as:

* "test" drive to prove concept
* system stress evaluation
* system performance evaluation
* duty cycle stability

The lines between stress, performance and duty cycle testing can be
very grey at times even for the fully aware.  They tend to have very
common elements in how these types of tests are conducted.

If an "application set" of behaviour exists, then test cases and
programs can be created to simulate such behaviour in many instances. 
The advantage of the test case and test programs is they are made in
such a way to control the variables to be tested.  A "real" world
application has a number of conditions it is using and that generally
cannot be controlled, even loosely controlled, most of time.  Using
real world applications has a use, but is not a replacement for
determining the necessary test conditions and how to effect those test
conditions.  Testing is about controlling the variables such that the
objective of the test can be executed and evaluated as objectively as
possible.

>> Are there better way to perform the test besides using benchmark
>tools> like this?
>
>Run the applications you really care about.  There is also a good set
>of benchmarks, including application specific ones at
>http://lbs.sourceforge.net/.  

If "Benchmarks are evil" then why are you now suggesting any
benchmarks?  Understand the point you made that benchmarks often get
missused.  I will give no argument on that latter missuse point.  I
just hope the benchmarks suggest are more prone to proper use than the
typical misuse.

What is key and core to the original company freshman effort is
tofirst research and determine what are the key patterns and
conditions of the system that need to be evaluated.  Then see if there
are existing tools that do the tests or can be easly changed to do so
use those.  Any test conditons and metric information that cannot be
found that is part of the exit criteria of a test will then need to be
created from scratch.


>-- 
>Nate Straz                                             
>nstraz@sgi.com sgi, inc                                          
>http://www.sgi.com/ Linux Test Project                               
>  http://ltp.sf.net/
>


Regards,

John L. Males
Software I.Q. Consulting
Toronto, Ontario
Canada
21 June 2002 18:58


==================================================================


According to Steve McConnell in:
After the Gold Rush: Creating a True Profession of
Software Engineering
About 50% of the current software engineering body of knowledge
is stable and will still be relevant 30 years from now.


Please BCC me by replacing after the "@" as follows"
TLD =         The last three letters of the word internet
Domain name = The first three letters of the word "theory",
              followed by the first three letters of the word
              "offsite", followed by the first three letters
              of the country "Iceland".
My appologies in advance for the jumbled eMail address
and request to BCC me, but SPAM has become a very serious
problem.  The eMail address in my header information is
not a valid eMail address for me.  I needed to use a valid
domain due to ISP SMTP screen rules.
--=.hB40j7GXc1X7II
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iEYEARECAAYFAj0Tr4kACgkQSeCOqZntNWU7VQCglTy1cdyplS9Kzn3NKmsfpp22
NywAoK37LWyYDUPU1HX6uyhbB6JZG+jU
=8GBZ
-----END PGP SIGNATURE-----

--=.hB40j7GXc1X7II--

