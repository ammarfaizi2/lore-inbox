Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273333AbRKEWA6>; Mon, 5 Nov 2001 17:00:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281372AbRKEWAs>; Mon, 5 Nov 2001 17:00:48 -0500
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:54156 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S273333AbRKEWAg>;
	Mon, 5 Nov 2001 17:00:36 -0500
Message-ID: <3BE70B9A.1010904@candelatech.com>
Date: Mon, 05 Nov 2001 14:58:50 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: Tim Jansen <tim@tjansen.de>
CC: Rik van Riel <riel@conectiva.com.br>, dalecki@evision.ag,
        Stephen Satchell <satch@concentric.net>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Jakob =?ISO-8859-1?Q?=D8stergaard?= <jakob@unthought.net>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        Alexander Viro <viro@math.psu.edu>, John Levon <moz@compsoc.man.ac.uk>,
        linux-kernel@vger.kernel.org,
        Daniel Phillips <phillips@bonn-fries.net>
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
In-Reply-To: <Pine.LNX.4.33L.0111051638230.27028-100000@duckman.distro.conectiva> <160qqc-1ClvWqC@fmrl04.sul.t-online.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Tim Jansen wrote:

> On Monday 05 November 2001 19:40, Rik van Riel wrote:
> 
>>I think you've hit the core of the problem. There is no magical
>>bullet which will stop badly written userland programs from
>>breaking, but the kernel developers should have the courtesy
>>of providing documentation for the /proc files so the writers
>>of userland programs can have an idea what to expect.
>>
> 
> I think the core insight is that if the kernel continues to have dozens of 
> "human-readable" file formats in /proc, each should to be documented using a 
> BNF description that can guarantee that the format is still valid in the 
> future, even if there is the need to add additional fields. 
> The result of this is, of course, that it may be very hard to write 
> shell scripts that won't break sooner or later and that accessing the data in 
> C is much more work than a simple scanf.


So if BNF makes it harder for shell scripts and sscanf, and harder for
the kernel developers...what good does it do???  I definately don't advocate
anything more than some simple documentation about whatever format the proc
module writer uses.  All of these interfaces (proc, ioctl, ...) end up being
hacks at some point, but a _documented_ hack can be called a feature :)


> 
> bye...
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 


-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


