Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264913AbSJaBMd>; Wed, 30 Oct 2002 20:12:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265079AbSJaBMd>; Wed, 30 Oct 2002 20:12:33 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:19432 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264913AbSJaBMb>;
	Wed, 30 Oct 2002 20:12:31 -0500
Message-ID: <3DC08403.5090905@us.ibm.com>
Date: Wed, 30 Oct 2002 17:14:43 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesse Barnes <jbarnes@sgi.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] pcibus_to_node() addition to topology infrastructure
References: <3DC06E75.6010003@us.ibm.com> <20021031000326.GA3049@sgi.com> <3DC0782D.20401@us.ibm.com> <20021031005906.GA1365@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Barnes wrote:
> On Wed, Oct 30, 2002 at 04:24:13PM -0800, Matthew Dobson wrote:
> 
>>Ah, yes...  The p-bricks, i-bricks, etc. right?
> 
> 
> Yup.
> 
> 
>>Yes, I suppose a round-robin return for the SGI version of the macro 
>>would work...  Certainly not ideal, but it would work.  The problem is 
> 
> 
> Can you think of any better way to do it?  Perhaps make pcibus_to_node
> return a list of nodes?

Yeah... I was thinking about having it return a bitmask...  It makes it 
a bit of a pain to iterate through the mask, only to find that in most 
cases there is only one bit set in the mask. :(

It's a bit late in the day... I'll mull this over and see if I can come 
up with something good.

Cheers!

-Matt

