Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285764AbRLHCJE>; Fri, 7 Dec 2001 21:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285763AbRLHCI5>; Fri, 7 Dec 2001 21:08:57 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:38406 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S285766AbRLHCIk>; Fri, 7 Dec 2001 21:08:40 -0500
Message-ID: <3C117612.4060904@zytor.com>
Date: Fri, 07 Dec 2001 18:08:18 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en, sv
MIME-Version: 1.0
To: mjustice@austin.rr.com
CC: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: highmem question
In-Reply-To: <Pine.LNX.4.30.0112071404280.29154-100000@mustard.heime.net> <01120719534703.00764@bozo> <20011208015446.GC32569@suse.de> <01120720102404.00764@bozo>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marvin Justice wrote:

>>That's because of highmem page bouncing when doing I/O. There is indeed
>>a solution for this -- 2.5 or 2.4 + block-highmem-all patches will
>>happily do I/O directly to any page in your system as long as your
>>hardware supports it. I'm sure we're beating w2k with that enabled :-)
>>
> 
> Will your patch lead to better performance than the CONFIGH_HIGHMEM=n case? 
> Unfortunately, W2K with any amount of memory beat Linux with no highmem (see 
> http://www.uwsg.indiana.edu/hypermail/linux/kernel/0110.3/0375.html ) so my 
> PHB decided to hold off on Linux for now.
> 


Depends if you need the extra memory or not.

	-hpa


