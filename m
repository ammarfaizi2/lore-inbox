Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129030AbRBIS5n>; Fri, 9 Feb 2001 13:57:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129234AbRBIS5d>; Fri, 9 Feb 2001 13:57:33 -0500
Received: from hilbert.umkc.edu ([134.193.4.60]:7428 "HELO tesla.umkc.edu")
	by vger.kernel.org with SMTP id <S129030AbRBIS50>;
	Fri, 9 Feb 2001 13:57:26 -0500
Message-ID: <3A843D57.C4D9C35D@kasey.umkc.edu>
Date: Fri, 09 Feb 2001 12:56:23 -0600
From: "David L. Nicol" <david@kasey.umkc.edu>
Organization: University of Missouri - Kansas City   supercomputing infrastructure
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
Newsgroups: comp.os.linux.misc,comp.os.linux.advocacy
To: Kansas City Perl Mongers <kansas-city-pm-list@happyfunball.pm.org>,
        mosix list <mosix-list@cs.huji.ac.il>, linux-kernel@vger.kernel.org
Subject: book review: Understanding the LINUX Kernel
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Understanding the Linux Kernel
 Daniel P. Bovet and Marco Cesati
 O'Reilly, 2000
  
 Book web site (including a sample chapter) is here:
 http://www.oreilly.com/catalog/linuxkernel/
  
Developed and tested as lecture notes for university classes
in which the 2.2 kernel was examined, the new O'Reilly book
Understanding The LINUX Kernel is an exhaustive enumeration of
features of the ascendent modern platform.

If you want to know more about what is involved in writing
device drivers, or respect the complexity required to pull off
a trick like MOSIX, and the flexibility of a platform that
provides a ptrace() debugging function that makes it easy, this
book may be for you.

I fear the book would have made much less sense to me had I not
taken university courses in microprocessor architecture and
OS theory, but then I would not have been able to skim those
parts, clear and concise, quite as quickly as I did.

It is written clearly, and is full of internal references to
other chapters where ideas are expanded, to see how it all
works together.

Instructions are given, for instance, on how to fiddle your
kernel configuration so that microsoft windows programs are
recognized from their magic signatures and WINE can be invoked
to handle them; and other advanced 2.2 features.

Each chapter ends with the most up-to-date information about changes
for 2.4 that were available at the end of 2000; such as the
increased number of local kernel locks and the improved VM page
swap donor selection algorithm.

Occasional assertions that do not match my understanding do appear,
such as a bit on scheduling that seems to imply that a "fair
scheduling patch" is a standard item instead of an option;  I
suspect it had been applied to the kernels examined in the class setting,
as it would make a very tidy little homework assignment.

At the end of the book there is an index of routines against the files
they are found in.

http://www.amazon.com/exec/obidos/ASIN/0596000022/tipjartransactioA

The preface claims that facts were checked by Alan Cox himself.



-- 
                      David Nicol 816.235.1187 dnicol@cstp.umkc.edu
                          "I don't care how they do it in New York"

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
