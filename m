Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S160047AbPLXWyi>; Fri, 24 Dec 1999 17:54:38 -0500
Received: by vger.rutgers.edu id <S160057AbPLXWyT>; Fri, 24 Dec 1999 17:54:19 -0500
Received: from amdext2.amd.com ([163.181.251.1]:35858 "EHLO amdext2.amd.com") by vger.rutgers.edu with ESMTP id <S160022AbPLXWyA>; Fri, 24 Dec 1999 17:54:00 -0500
From: nathan.zook@amd.com
Message-ID: <AB4CB1CC6547D21197B00008C7F48FB402C10F3C@txexmta0.amd.com>
To: lightmanaj@earthlink.net, linux-kernel@vger.rutgers.edu
Subject: RE: Linux Kernel Floating Point Emulation and CORDIC
Date: Fri, 24 Dec 1999 16:53:56 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain
Sender: owner-linux-kernel@vger.rutgers.edu

EEEEEwwww!  Cordic is UGLY!  There is a reason that Intel & we (AMD) have
gone with polyonmial & rational function approximations.  BTW, our
algorithms are quite accurate.  If you are running in another world, or just
want to emulate, look into equal-ripple approximations.  You will chew some
serious processor power finding good functions, but what you get can be
nice.

Nathan


> -----Original Message-----
> From:	Arthur Jerijian [SMTP:lightmanaj@earthlink.net]
> Sent:	Thursday, December 23, 1999 5:58 PM
> To:	linux-kernel@vger.rutgers.edu
> Subject:	Linux Kernel Floating Point Emulation and CORDIC
> 
> For the mathematics and theoretical computer science enthusiasts here on
> this
> list:
> 
> I have taken a look at the source code of the Linux Kernel floating point
> emulation engine for i386 (as of 2.2.12, don't know if it changed in
> 2.3.x). I
> noticed that it uses Taylor/Maclaurin polynomials to approximate the sine,
> cosine, tangent, and inverse tangent functions. Wouldn't CORDIC be a
> better
> algorithm for computing trigonometric and exponential functions instead?
> CORDIC
> is a method for calculating mathematical functions using only addition,
> shifting, and looking up entries in a table. More details can be found at 
> http://www.ezcomm.com/%7Ecyliax/Articles/RobNav/sidebar.html
> 
> Thanks,
> --Arthur
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.rutgers.edu
> Please read the FAQ at http://www.tux.org/lkml/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
