Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <154200-27302>; Mon, 8 Feb 1999 04:28:37 -0500
Received: by vger.rutgers.edu id <154434-27302>; Mon, 8 Feb 1999 04:28:18 -0500
Received: from styx.cs.kuleuven.ac.be ([134.58.40.3]:40512 "EHLO styx.cs.kuleuven.ac.be" ident: "TIMEDOUT2") by vger.rutgers.edu with ESMTP id <154144-27302>; Mon, 8 Feb 1999 04:25:47 -0500
Date: Mon, 8 Feb 1999 10:43:21 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: "Robert G. Werner" <rwerner@lx1.microbsys.com>
Cc: Ben Bridgwater <bennyb@ntplx.net>, kernel-list <linux-kernel@vger.rutgers.edu>
Subject: Re: Linux Graphics Architecture (format fixed)
In-Reply-To: <Pine.LNX.3.96.990207125900.16041E-100000@lx1.microbsys.com>
Message-ID: <Pine.LNX.4.03.9902081041570.29366-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu

On Sun, 7 Feb 1999, Robert G. Werner wrote:
> What was the consensus,  Geert?  Knowing what the fbdev people decided might
> squash out of gamut discussions on lkml.

For what it's worth, Fabrice Bellard <bellard@email.enst.fr> wrote:
| I read the papers of SGI and the related papers about XFree 3d. I
| understand that implementing an acceleration API in fbdev will clearly
| hurt the performances and add too much bloat in ther kernel, especially
| for 3D acceleration. I understand too that if the hardware is well
| designed, the kernel support for the graphical acceleration can be
| small, consistent and elegant.
|
| So I changed my mind and I admit now that we should concentrate in
| puting in fbcon/fbdev only things related to text mode and mode
| switching.

References:

  - SGI paper:

    http://trant.sgi.com/opengl/docs/Direct/direct.html
       
  - XFRee86-3D:

    http://www.dpmms.cam.ac.uk/~werdna/XFree86-3D-status.html

Greetings,

						Geert

--
Geert Uytterhoeven                     Geert.Uytterhoeven@cs.kuleuven.ac.be
Wavelets, Linux/{m68k~Amiga,PPC~CHRP}  http://www.cs.kuleuven.ac.be/~geert/
Department of Computer Science -- Katholieke Universiteit Leuven -- Belgium


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
