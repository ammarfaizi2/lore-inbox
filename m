Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136796AbREBDEV>; Tue, 1 May 2001 23:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136795AbREBDEL>; Tue, 1 May 2001 23:04:11 -0400
Received: from cvsftp.cotw.com ([208.242.241.39]:55044 "EHLO cvsftp.cotw.com")
	by vger.kernel.org with ESMTP id <S136794AbREBDD5>;
	Tue, 1 May 2001 23:03:57 -0400
Message-ID: <3AEF7C43.9955C970@cotw.com>
Date: Tue, 01 May 2001 22:17:23 -0500
From: "Steven J. Hill" <sjhill@cotw.com>
Reply-To: sjhill@cotw.com
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: Question on including 'math.h' from C runtime...
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings.

I checked in the archives and did not see a discussion of this
anywhere. I have received some Linux kernel code from a project
that I have inherited and a couple of the drivers are including
math.h from the C library. This being the header file from
'/usr/include/math.h' in most cases. There are only two places
in the kernel that also include this header file. They are:

   drivers/atm/iphase.c
   drivers/net/hamradio/soundmodem/gentbl.c

As far as I can tell '/usr/include/math.h' is just full of
defines and the header files it includes are also a bunch
of defines with a few macro functions sprinkled in. Can someone
shed light on if this is bad or not and why it would be done
or necessary? Thanks.

-Steve

-- 
 Steven J. Hill - Embedded SW Engineer
 Public Key: 'http://www.cotw.com/pubkey.txt'
 FPR1: E124 6E1C AF8E 7802 A815
 FPR2: 7D72 829C 3386 4C4A E17D
