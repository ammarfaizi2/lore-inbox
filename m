Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316459AbSFDFUQ>; Tue, 4 Jun 2002 01:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316475AbSFDFUO>; Tue, 4 Jun 2002 01:20:14 -0400
Received: from graze.net ([65.207.24.2]:31469 "EHLO graze.net")
	by vger.kernel.org with ESMTP id <S316459AbSFDFT4>;
	Tue, 4 Jun 2002 01:19:56 -0400
Subject: kernel routing of IPSec / VMWare
From: "Brian C. Huffman" <huffman@graze.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 04 Jun 2002 01:19:53 -0400
Message-Id: <1023167993.2914.12.camel@zaphod>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All, 

This may not be the place, but I've been struggling w/ a problem w/
VMWare for quite some time.  Their support has not been helpful and I
have not found anything by searching the net.  

Is there some reason that linux does not route all IPSec traffic?  I've
tried NATing using both IPtables and using the new built-in NAT that
comes with the latest versions of VMWare and I can never get it to work
w/ CheckPoint's SecurRemote product.  When I do a "bridged" ethernet (in
VMWare), it always works.  Looking at the packets, it seems as though it
might not be passing some of the ESP packets.  

The way that we have checkpoint setup it is doing UDP encapsulation of
the IPSec (otherwise it would not be possible to do this w/ NAT).  This
is with all the latest 2.4 kernels (haven't tried 2.4.19, though). 

Any suggestions would be helpful. 

Thanks, 
Brian 





