Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154714AbPGXByg>; Fri, 23 Jul 1999 21:54:36 -0400
Received: by vger.rutgers.edu id <S154303AbPGXByQ>; Fri, 23 Jul 1999 21:54:16 -0400
Received: from MERCURY.CS.UREGINA.CA ([142.3.200.53]:5553 "EHLO MERCURY.CS.UREGINA.CA") by vger.rutgers.edu with ESMTP id <S154306AbPGXByF>; Fri, 23 Jul 1999 21:54:05 -0400
Date: Fri, 23 Jul 1999 19:54:00 -0600 (CST)
From: Kamran Karimi <karimi@cs.uregina.ca>
To: linux-kernel@vger.rutgers.edu
Subject: DIPC for PowerPC, MIPS, and SPARC
Message-ID: <Pine.SGI.3.91.990723194928.18857R-100000@MERCURY.CS.UREGINA.CA>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu

Hi,

 I did a blind port of DIPC (http://wallybox.cei.net/dipc) to SPARC and 
PowerPC processors. Here blind means that due to the lack of equipment, I 
have not done any tests, not even a kernel compile. Ralf Baechle did the 
port to MIPS and it has been compiled successfully. I would be grateful if
someone on this list could test the patch, available by anonymous FTP
from orion.cs.uregina.ca /pub/dipc. More adventurous people can test the
whole system (available from the same place). You should be able to mix 32 
bit machines in the same DIPC cluster. Contact me if you have any 
questions or problems. The following is the readme file accompanying 
the new patch. 

The file dipc-patch-1.1d.gz was prepared against a 2.2.10 linux
kernel. It is based on the DIPC 1.1c kernel patch and has the following
additions:
 
 *) The port to MIPS by Ralf Baechle (not tested in a cluster)
 *) The port to SPARC (blind, not compiled on target machine)
 *) The port to PowerPC (blind, not compiled on target machine)
 *) Some memory management modifications as proposed by David Miller (This
    might have introduced bugs into DIPC's shared memory subsystem)

 The rest of the package, including the user-space dameon dipcd, some tools
and example programs, and also the documentation of DIPC, can be found in
the file dipc-1.1c.tgz.

 Please test the patch, and if possible the whole system in a cluster, and
report the results to me or to linux-dipc@wallybox.cei.net.

-Kamran Karimi

 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
