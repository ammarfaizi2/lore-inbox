Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270550AbRHISvX>; Thu, 9 Aug 2001 14:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270549AbRHISvO>; Thu, 9 Aug 2001 14:51:14 -0400
Received: from neon-gw.transmeta.com ([63.209.4.196]:26630 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S270552AbRHISvH>; Thu, 9 Aug 2001 14:51:07 -0400
Message-ID: <3B72DB90.5060502@zytor.com>
Date: Thu, 09 Aug 2001 11:50:56 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Tim Walberg <twalberg@mindspring.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Setting up MTRRs for 4096MB RAM
In-Reply-To: <Pine.LNX.4.21.0108091306550.18150-100000@willow.commerce.uk.net> <9kuils$q67$1@cesium.transmeta.com> <20010809130641.B10425@mindspring.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Walberg wrote:
> On 08/09/2001 10:53 -0700, H. Peter Anvin wrote:
> 
>>>	
>>>	Intel MTRRs have to be a multiple of 2, so you'd need 2 MTRRs if you
>>>	wanted to cover 3 GB.  0x80000000 is a multiple of 2; 0xC0000000
>>>	isn't, and 0xFFFFFFFF definitely isn't, although 0x100000000 is.
>>>
> 
> Since when? Seems to me bit 0 of 0xC0000000 is 0, therefore it is
> a multiple of two. Perhaps you meant "power of 2" (i.e. only one bit
> set in the binary representation)?
> 

Yes, power of 2.

	-hpa

