Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S156976AbPLXBG7>; Thu, 23 Dec 1999 20:06:59 -0500
Received: by vger.rutgers.edu id <S156915AbPLXBGj>; Thu, 23 Dec 1999 20:06:39 -0500
Received: from penguin.prod.itd.earthlink.net ([207.217.120.134]:38090 "EHLO penguin.prod.itd.earthlink.net") by vger.rutgers.edu with ESMTP id <S156897AbPLXBGW>; Thu, 23 Dec 1999 20:06:22 -0500
From: Arthur Jerijian <lightmanaj@earthlink.net>
To: linux-kernel@vger.rutgers.edu
Subject: Linux Kernel Floating Point Emulation and CORDIC
Date: Thu, 23 Dec 1999 15:58:22 -0800
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Message-Id: <99122316092902.01246@cel2>
Content-Transfer-Encoding: 7BIT
Sender: owner-linux-kernel@vger.rutgers.edu

For the mathematics and theoretical computer science enthusiasts here on this
list:

I have taken a look at the source code of the Linux Kernel floating point
emulation engine for i386 (as of 2.2.12, don't know if it changed in 2.3.x). I
noticed that it uses Taylor/Maclaurin polynomials to approximate the sine,
cosine, tangent, and inverse tangent functions. Wouldn't CORDIC be a better
algorithm for computing trigonometric and exponential functions instead? CORDIC
is a method for calculating mathematical functions using only addition,
shifting, and looking up entries in a table. More details can be found at 
http://www.ezcomm.com/%7Ecyliax/Articles/RobNav/sidebar.html

Thanks,
--Arthur

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
