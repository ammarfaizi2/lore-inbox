Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <153881-219>; Sun, 13 Dec 1998 00:07:36 -0500
Received: from mailhost.dircon.co.uk ([194.112.32.65]:1416 "EHLO mailhost.dircon.co.uk" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with ESMTP id <154957-219>; Sat, 12 Dec 1998 20:47:49 -0500
Date: Sun, 13 Dec 1998 02:10:19 +0000 (GMT)
From: Chris Butterworth <cdb@europa.dircon.co.uk>
Reply-To: cdb@io.com
To: Shane Wegner <shane@cm.nu>
cc: linux-kernel@vger.rutgers.edu
Subject: Re: problems with swapfiles under 2.0.x
In-Reply-To: <Pine.LNX.4.05.9812111539370.27816-100000@continuum.cm.nu>
Message-ID: <Pine.LNX.3.93.981213020451.430A-100000@sunrise.europa.dircon.co.uk>
Reciept-Requested-To: cdb@io.com
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu

On Fri, 11 Dec 1998, Shane Wegner wrote:

> Hello all,
> 
> I am running into a problem with swap files under Linux 2.0.36.  If I run
> mkswap swapfile  and swapon swapfile it works fine.  However, if swapfile
> is on an nfs mounted directory, the swapon(2) call fails with "Invalid
> argument."  It is necessary for me to use a swap file on a remote system
> over the network.  Why isn't this possible over an nfs mount?  It should
> just see it as a regular file and accept it.  Any ideas of how I could get
> around this one?


  Swapping via NFS is not supported... for some notes about this, and 
  pointers to patches see 

  http://www-math.math.rwth-aachen.de/~LBFM/claus/nfs-swap/nfs-swap.html




-- 
Old .sig lost in a filesystem 'accident'. 

Write 100 lines:
 Back up all filesystems before hacking the kernel.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
