Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <283414-25725>; Sun, 11 Apr 1999 20:14:23 -0400
Received: by vger.rutgers.edu id <283333-25725>; Sun, 11 Apr 1999 20:12:01 -0400
Received: from www.orl.ilstu.edu ([138.87.80.180]:2413 "EHLO www.orl.ilstu.edu" ident: "tphocki") by vger.rutgers.edu with ESMTP id <218341-25725>; Sun, 11 Apr 1999 20:08:08 -0400
From: Tim Hockin <tphocki@www.orl.ilstu.edu>
Message-Id: <199904120023.TAA17609@www.orl.ilstu.edu>
Subject: ANNOUNCE: Pset-0.60 complete rewrite
To: linux-kernel@vger.rutgers.edu, linux-smp@vger.rutgers.edu
Date: Sun, 11 Apr 1999 19:23:18 -0500 (CDT)
Content-Type: text
Sender: owner-linux-kernel@vger.rutgers.edu

PSET - Processor Sets for the Linux kernel
http://isunix.it.ilstu.edu/~thockin/pset/

Announcing pset/sysmp for Linux/SMP !!
--------------------------------------------------------
This project has undergone a complete, from-scratch rewrite.

The goal of this project is to make a source compatible and functionally
equivalent version of pset (as defined by SGI - partially removed from
their IRIX kernel 6.4 and up) for Linux.  This enables users to determine
which processor or set of processors a process may run on.  Possible uses
include forcing threads to seperate processors, timings, and probably more.

It is focused around the syscall sysmp().  This function takes a number of
parameters that determine which function is requested.  Functions include:
        * binding a process/thread to a specific CPU
        * restricting a CPU's ability to execute some processes
        * restricting a CPU from running at all
        * forcing a cpu to run _only_ one process (and its children)
        * getting information about a CPU's state
        * creating/destroying sets of processors, to which processes may be
          bound

IMPORTANT
---------
Anyone who downloaded any other version made available in the past,
PLEASE get the latest version. This is a COMPLETE REWRITE :)

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
