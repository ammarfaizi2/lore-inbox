Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317207AbSEXQbg>; Fri, 24 May 2002 12:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317213AbSEXQbf>; Fri, 24 May 2002 12:31:35 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:25056 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S317207AbSEXQbe>; Fri, 24 May 2002 12:31:34 -0400
Date: Fri, 24 May 2002 09:31:56 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Roy Sigurd Karlsbakk <roy@karlsbakk.net>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.4 VM sucks. Again
Message-ID: <423360000.1022257916@flay>
In-Reply-To: <E17BHiQ-0006mJ-00@the-village.bc.nu>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I'm not sure exactly what Roy was doing, but we were taking a machine
>> with 16Gb of RAM, and reading files into the page cache - I think we built up
>> 8 million buffer_heads according to slabinfo ... on a P4 they're 128 bytes each,
>> on a P3 96 bytes.
> 
> The buffer heads one would make sense. I only test on realistic sized systems. 

Well, it'll still waste valuable memory there too, though you may not totally kill it.

> Once you pass 4Gb there are so many problems its not worth using x86 in the
> long run

Nah, we just haven't fixed them yet ;-)

M.

