Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280331AbRJaR3w>; Wed, 31 Oct 2001 12:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280338AbRJaR3Y>; Wed, 31 Oct 2001 12:29:24 -0500
Received: from [207.8.4.6] ([207.8.4.6]:41881 "EHLO one.interactivesi.com")
	by vger.kernel.org with ESMTP id <S280331AbRJaR3P>;
	Wed, 31 Oct 2001 12:29:15 -0500
Message-ID: <3BE034F6.8070201@interactivesi.com>
Date: Wed, 31 Oct 2001 11:29:26 -0600
From: Timur Tabi <ttabi@interactivesi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: linux-kernel@vger.kernel.org
Subject: Re: Module Licensing?
In-Reply-To: <Pine.LNX.4.33L.0110311505160.2963-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:

> Since your program, which happens to consist of one open
> source part and one proprietary part, is partly a derived
> work from the kernel source (by using kernel header files
> and the inline functions in it) your whole work must be
> distributed under the GPL.


I contest your meaning of the word "work".  The open source portion of my 
module is one "work", and the closed source portion is another "work".  I 
could deliver these two works as separate tarballs, if I wanted.

Not only that, but the closed-source portion of my driver is not derived from 
any GPL program, so the phrase "contains or is derived from the Program" does 
not apply to it, because it:

1. Does not contain any part of any GPL Program
2. Is not derived from any GPL Program

>>Our open source bits are GPL because they are "derived" from the kernel
>>source, which is also GPL.
> 
> "open source bits" ... from "the work as a whole"  ?


The point I'm trying to make is that I can play the semantics game very 
easily, and still not be forced to open-source the closed-source portions of 
my driver.  Because of the way Linux loads modules, I could take all the 
open-source portions and link them into one .o file, and then insmod that .o 
file without any problems.  Then the closed-source portion would also be 
insmod'ed.  The only issue is that closed-source portion would fail to load if 
the open-source portion is not already loaded.

