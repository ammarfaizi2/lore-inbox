Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292852AbSCRUnr>; Mon, 18 Mar 2002 15:43:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292850AbSCRUnh>; Mon, 18 Mar 2002 15:43:37 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:34308 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S292842AbSCRUnY>; Mon, 18 Mar 2002 15:43:24 -0500
Message-ID: <3C96510A.24CDE6BC@zip.com.au>
Date: Mon, 18 Mar 2002 12:41:46 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Colin Leroy <colin@colino.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: question about 2.4.18 and ext3
In-Reply-To: <20020318180158.2886dd4a.colin@colino.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Colin Leroy wrote:
> 
> Hello all,
> 
> I really hope I'm not asking a FAQ, i looked in the archives since 15 Feb
> and didn't see anything about this.
> 
> I upgraded from 2.2.20 to 2.4.18 on my powerbook two weeks ago, and
> compiled ext3 in the kernel in order to quietly crash :)
> 
> However, I had about a dozen strange crashes, sometimes when the computer
> woke up from sleep, sometimes when launching a program : every visible
> soft died, then X, then blackscreen, and the computer didn't even answer
> pings. So I reset the computer and here, each time, yaboot (ppc equivalent
> of lilo) told me that "cannot load image". Booting and fscking from a
> rescue CD showed that superblock was corrupt.

It may be a yaboot/ext3 incompatibility.  Your version of yaboot
may not know how to mount a needs-recovery ext3 filesystem.
There are some words on this at
http://www.zip.com.au/~akpm/linux/ext3/ext3-usage.html

I am told that yaboot 1.3.5 and later will do the right thing.
What version are you using?

-
