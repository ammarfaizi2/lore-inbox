Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S157086AbPJDDOr>; Sun, 3 Oct 1999 23:14:47 -0400
Received: by vger.rutgers.edu id <S156782AbPJDDOX>; Sun, 3 Oct 1999 23:14:23 -0400
Received: from isunix.it.ilstu.edu ([138.87.124.103]:1110 "EHLO isunix.it.ilstu.edu") by vger.rutgers.edu with ESMTP id <S156961AbPJDDM3>; Sun, 3 Oct 1999 23:12:29 -0400
From: Tim Hockin <thockin@isunix.it.ilstu.edu>
Message-Id: <199910040304.WAA13049@isunix.it.ilstu.edu>
Subject: New Pset version
To: linux-kernel@vger.rutgers.edu, linux-smp@vger.rutgers.edu
Date: Sun, 3 Oct 1999 22:04:53 -0500 (CDT)
Content-Type: text
Sender: owner-linux-kernel@vger.rutgers.edu

The newest version of Pset (against 2.2.12 still) is now available.

This is version 0.65, and can be found at
http://isunix.it.ilstu.edu/~thockin/pset/.


Attached is the original announcement.  If this is interesting to you,
please use it, and let me know how it goes!

Thanks,
Tim




PSET - Processor Sets for the Linux kernel
http://isunix.it.ilstu.edu/~thockin/pset/

Announcing pset/sysmp for Linux/SMP !!
--------------------------------------------------------
This project has undergone a complete, from-scratch rewrite since v0.5x.
If you are using a version earlier than 0.60, I encourage you to get to
at LEAST 0.60.  If you are using anything less than the latest, I
reccomend you get the latest :)

The goal of this project is to make a source compatible and functionally
equivalent version of pset (as defined by SGI - partially removed from
their IRIX kernel 6.4 and up) for Linux.  This enables users to determine 
which processor or set of processors a process may run on.

It is focused around the syscall sysmp().  This function takes a number of
parameters that determine which function is requested.  Functions include:
	* binding a process/thread to a specific CPU
	* restricting a CPU's ability to execute some processes
	* restricting a CPU from running at all
	* forcing a cpu to run _only_ one process (and its children)
	* getting information about a CPU's state
	* creating/destroying sets of processors, to which processes may be
	  bound

A secondary goal is to provide a library of routines that will act as wrappers 
for sysmp() and provide source-compatibility with other UNIX API's which do the 
same thing.  Currently targeted are processor_bind() + family and bind_to_cpu() 
+ family.

Tim
thockin@isunix.it.ilstu.edu

DISCLAIMER
----------
All standard disclaimers, blah blah blah.  This is not guaranteed to be
useful, or to even work.  There is no warrantee, not even that of fitness
for a purpose.  For all I know, your system will blow up.  It hasn't
happened yet, but it could.  It's not my fault. :)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
