Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315522AbSEQJg3>; Fri, 17 May 2002 05:36:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315523AbSEQJg2>; Fri, 17 May 2002 05:36:28 -0400
Received: from [202.135.142.194] ([202.135.142.194]:13841 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S315522AbSEQJg0>; Fri, 17 May 2002 05:36:26 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@zip.com.au>
Cc: Ghozlane Toumi <ghoz@sympatico.ca>, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: [PATCH] Fix BUG macro 
In-Reply-To: Your message of "Thu, 16 May 2002 23:44:29 MST."
             <3CE4A6CD.75039761@zip.com.au> 
Date: Fri, 17 May 2002 19:39:30 +1000
Message-Id: <E178eCw-0008ML-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3CE4A6CD.75039761@zip.com.au> you write:
> It would help if you told us whether you're using a toolchain which
> combines strings across .o files.

No, am not.

> Presumably, you're not.  So the space savings which you're seeing
> are due to lessening the bloat which is caused by the inline functions
> in headers which expand BUG().   Which is what out_of_line_bug() does too.

... which hasn't been accepted by Linus...

> Assuming the toolchain fixes that for us in 2.5, you've gone and added
> zillions of function names to the kernel image.

I thought you said the toolchain would merge them?

I don't care about the bloat: I care about the compile time exploding
because every file is different in different trees, due to the
filename strings.

It'd be very nice to have a solution to this, and I'll keep sending
patches to Linus until he applies them or says "no do it this way".

Cheers!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
