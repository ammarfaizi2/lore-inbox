Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278940AbRKXVdI>; Sat, 24 Nov 2001 16:33:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279394AbRKXVc7>; Sat, 24 Nov 2001 16:32:59 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:46600 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S278940AbRKXVck>; Sat, 24 Nov 2001 16:32:40 -0500
Message-ID: <3C0011EE.3010401@transmeta.com>
Date: Sat, 24 Nov 2001 13:32:30 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Marcelo Tosatti <marcelo@conectiva.com.br>, Phil Sorber <aafes@psu.edu>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.16-pre1
In-Reply-To: <Pine.LNX.4.33.0111241311040.2591-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> On Sat, 24 Nov 2001, Marcelo Tosatti wrote:
> 
>>>Are these going to appear on the front page of kernel.org?
>>>
>>They have to...
>>
>>I'm sure hpa will do that as soon as he has time to...
>>
> 
> I also decided that the suggestion to move the "testing" subdirectory down
> to below the kernel that the directory is for is a good idea.
> 
> So I moved all the 2.5.x testing stuff to kernel/v2.5/testing, leaving the
> old kernel/testing directory basically orphaned.
> 
> Marcelo could either take over the old directory (which will make his
> pre-patches show up on kernel.org automatically), or preferably just do
> the same thing, and make the v2.4 test patches in v2.4/testing (which will
> also require support from the site admin, who is probably overworked as-is
> with the RAID failures ;)
> 
> 			Linus
> 

I like this idea much better than Marcelo's idea, which requires yet a 
whole slew of ad hoc knowledge in the scripts -- there is just way too 
much of that already.  I'll try to implement this.

To summarize:

I'll expect v2.5 prepatches in v2.5/testing; v2.4 prepatches in 
v2.4/testing, and nothing else...

	-hpa

