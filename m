Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315429AbSEUSsB>; Tue, 21 May 2002 14:48:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315431AbSEUSsA>; Tue, 21 May 2002 14:48:00 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:61423 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S315429AbSEUSr7>; Tue, 21 May 2002 14:47:59 -0400
Date: Tue, 21 May 2002 14:47:59 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Ed Tomlinson <tomlins@cam.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC][PATCH] using page aging to shrink caches
Message-ID: <20020521144759.B1153@redhat.com>
In-Reply-To: <200205180010.51382.tomlins@cam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 18, 2002 at 12:10:51AM -0400, Ed Tomlinson wrote:
> I have never been happy with the way slab cache shrinking worked.  This is an
> attempt to make it better.  Working with the rmap vm on pre7-ac2, I have done
> the following.

Thank you!  This is should help greatly with some of the vm imbalances by 
making slab reclaim part of the self tuning dynamics instead of hard coded 
magic numbers.  Do you have any plans to port this patch to 2.5 for inclusion?  
It would be useful to get testing in the 2.5 before merging in 2.4.

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."
