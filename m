Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313070AbSEAPGz>; Wed, 1 May 2002 11:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313084AbSEAPGy>; Wed, 1 May 2002 11:06:54 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:11436 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S313070AbSEAPGx>; Wed, 1 May 2002 11:06:53 -0400
Message-ID: <3CD0047B.4060605@us.ibm.com>
Date: Wed, 01 May 2002 08:06:35 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc1) Gecko/20020417
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Guillaume Boissiere <boissiere@attbi.com>
CC: linux-kernel@vger.kernel.org, kernel-janitor-discuss@lists.sourceforge.net
Subject: Re: [STATUS 2.5]  May 1, 2002 (BKL status)
In-Reply-To: <3CCFBB21.9046.7889B0D2@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guillaume Boissiere wrote:
> There has also been a lot of work done by various people to 
> remove the BKL from many places, which leads to my question:
> does anyone has a URL with a list of all the places where the
> BKL should eventually be removed and who's working on it?
> 
> It seems like it would be most useful if someone was willing
> to maintain something like this, but it might be a lot of 
> work - I don't know how long the list would be...

I may not be the leading BKL expert, but I play one on TV :)

Perhaps one of the kernel-janitor people would like to assist me with 
this (cc'ing that list).  I'd be willing to keep a web page to list all 
current BKL uses and keep track of them as they are removed/added 
Perhaps a set of web pages which resemble the directory structure of the 
kernel tree would be helpful??

Here's a good question for kernel-janitor, and anyone else who's 
interested, what format describing BKL use would most encourage you to 
go and remove it?  We already have Rick Lindsley's Global spinlock list: 
  http://prdownloads.sourceforge.net/lse/locking_doc-2.4.16 .  The BKL 
use in there is somewhat dated, but might be a good start.

I have some awk scripts that I use on each new kernel release to check 
for new and removed uses of the BKL.  I can adapt these to start 
checking new BK changesets for BKL changes.

-- 
Dave Hansen
haveblue@us.ibm.com

