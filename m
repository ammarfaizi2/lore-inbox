Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266323AbSL2DzX>; Sat, 28 Dec 2002 22:55:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266356AbSL2DzX>; Sat, 28 Dec 2002 22:55:23 -0500
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:64522
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP
	id <S266323AbSL2DzX>; Sat, 28 Dec 2002 22:55:23 -0500
Subject: Re: [PATCH] Allow UML kernel to run in a separate host address
	space
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Jeff Dike <jdike@karaya.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Julian Seward <jseward@acm.org>
In-Reply-To: <200212282024.PAA03372@ccure.karaya.com>
References: <200212282024.PAA03372@ccure.karaya.com>
Content-Type: text/plain
Organization: 
Message-Id: <1041134621.17117.3.camel@ixodes.goop.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 28 Dec 2002 20:03:41 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-12-28 at 12:24, Jeff Dike wrote:
> 1 - Multiple address spaces per process
> 2 - Ability to make a child switch between address spaces
> 3 - Ability to manipulate a child's address space (i.e. mmap, munmap, mprotect
> on an address space which is not current->mm)

I suspect Valgrind could use this too at some point.  There hasn't been
much discussion about it yet, but I think Valgrind may well move towards
a more complete virtualization in a later round of development, and
isolating the virtual virtual address space from the Valgrind's real
virtual address space would be very useful.  (Jeff suggested the idea of
merging Valgrind and UML at some level, which does raise some
interesting possibilities.)

	J

