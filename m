Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S155303AbPHIBmg>; Sun, 8 Aug 1999 21:42:36 -0400
Received: by vger.rutgers.edu id <S155241AbPHIBgQ>; Sun, 8 Aug 1999 21:36:16 -0400
Received: from MERCURY.CS.UREGINA.CA ([142.3.200.53]:6712 "EHLO MERCURY.CS.UREGINA.CA") by vger.rutgers.edu with ESMTP id <S157080AbPHIBXr>; Sun, 8 Aug 1999 21:23:47 -0400
Date: Sun, 8 Aug 1999 19:23:40 -0600 (CST)
From: Kamran Karimi <karimi@cs.uregina.ca>
To: linux-kernel@vger.rutgers.edu
Subject: DIPC 2.0-pre3
Message-ID: <Pine.SGI.3.91.990808191520.7995A-100000@MERCURY.CS.UREGINA.CA>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu

Hi,

 I am currently preparing version 2.0 of DIPC (http://wallybox.cei.net/dipc).
It has been tested under i386 and to a lesser extent under PowerPC 
processors. MIPS and Alpha are also supported, but due to lack of 
equipment, they have not been tested yet.

 DIPC 2.0 handles its Distributed Shared Memory (DSM) subsystem 
completely different from previous versions: It no longer swaps out the 
pages. This has resulted in a considerable increase in the speed of DSM 
operations, and DIPC can now be easily used in clusters of diskless 
workstations. The kernel patch of DIPC has also become clean and simpler.

 You can grab dipc-2.0-pre3.tgz from orion.cs.uregina.ca /pub/dipc (You 
can check this place from time to time for updates). Please test it and 
let me know about the success or failures, especially if you have Alpha 
or MIPS machines.

 Yours, 
        Kamran Karimi

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
