Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <160207-8100>; Wed, 20 Jan 1999 21:45:26 -0500
Received: by vger.rutgers.edu id <155910-8093>; Wed, 20 Jan 1999 17:08:22 -0500
Received: from lsmls02.we.mediaone.net ([24.130.1.15]:48811 "EHLO lsmls02.we.mediaone.net" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with ESMTP id <156670-8100>; Wed, 20 Jan 1999 11:42:02 -0500
Message-ID: <36A60752.668C9631@alumni.caltech.edu>
Date: Wed, 20 Jan 1999 08:41:54 -0800
From: Dan Kegel <dank@alumni.caltech.edu>
X-Mailer: Mozilla 4.5 [de] (Win95; I)
X-Accept-Language: de
MIME-Version: 1.0
To: linux-kernel@vger.rutgers.edu
Subject: Regression testing?
References: <19990120031127Z157444-8100+9173@vger.rutgers.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-kernel@vger.rutgers.edu

Does anyone have access to some hefty benchmarks
suites like SPEC's, or regression tests
like the POSIX compliance test?
It might be a good idea to run 2.2.0-pre-x
through these to look for suprises
before going final with it.

The Posix test suite is downloadable from
http://www.itl.nist.gov/div897/ctg/posix_form.htm
See also http://www.standards.ieee.org/regauth/posix/
Even if we didn't actually pass all the tests,
it'd be good to know that we didn't oops.

The SPEC benchmarks can be purchased at
http://www.spec.org/cgi-bin/osgorder
for $700 or so.  The hard part is
actually having the patience to run them.
(I suspect if Linux or Alan asked nicely, they'd
donate a benchmark or two.   Or we could take
up a collection.  Or Alan's boss could pay.)
Three of the SPEC tests look interesting:

SPECweb96 stresses out HTTP networking.
SPEC SFS97 stresses out NFS networking.
SPEC SDM (System Development: Multitasking) 
stresses the kernel by simulating a large number of 
users running make, cp, diff, etc.

The point of running these benchmarks is not really
to say we're fast, but to see whether we can
actually get all the way through the benchmark
(which might take a day to run) without having
a functional error or a crash.
- Dan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
