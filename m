Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130507AbRCPOwG>; Fri, 16 Mar 2001 09:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130512AbRCPOv5>; Fri, 16 Mar 2001 09:51:57 -0500
Received: from mail.veka.com ([213.68.6.130]:25528 "EHLO veka.com")
	by vger.kernel.org with ESMTP id <S130507AbRCPOvm>;
	Fri, 16 Mar 2001 09:51:42 -0500
Content-Type: text/plain; charset=US-ASCII
From: Frank Fiene <frank.fiene@syntags.de>
Organization: Syntags GmbH
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.2-ac19 / ac20
Date: Fri, 16 Mar 2001 15:52:31 +0100
X-Mailer: KMail [version 1.2]
In-Reply-To: <Pine.LNX.4.10.10103160908530.31423-100000@coffee.psychology.mcmaster.ca>
In-Reply-To: <Pine.LNX.4.10.10103160908530.31423-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Message-Id: <01031615523100.00748@fflaptop>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 16. March 2001 15:09, Mark Hahn wrote:
> > Is there anything new in the ac19/ac20 patch that slows down
> > video output or system throughput. With ac18, i can watch dvd
> > using xine, but with ac9/ac20, the system is so slow, that 1/4 of
> > the frames are skipped.
> >
> > Any suggestions?
>
> does /proc/mtrr look sane?

Yes i think so.
First are two RAM expansion in my Thinkpad
Second is the memora on the mainboard
Third is the AGP-Video-Card memory !?

reg00: base=0x00000000 (   0MB), size= 256MB: write-back, count=1
reg01: base=0x10000000 ( 256MB), size=  64MB: write-back, count=1
reg02: base=0xe0000000 (3584MB), size=   4MB: write-combining, count=1

Same for 2.4.2 without ac patches.
-- 
Frank Fiene, SYNTAGS GmbH, Im Defdahl 5-10, D-44141 Dortmund, Germany
Security, Cryptography, Networks, Software Development
http://www.syntags.de mailto:Frank.Fiene@syntags.de
