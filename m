Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310348AbSCLCiB>; Mon, 11 Mar 2002 21:38:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310356AbSCLChy>; Mon, 11 Mar 2002 21:37:54 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4876 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S310348AbSCLChm>;
	Mon, 11 Mar 2002 21:37:42 -0500
Message-ID: <3C8D69E3.3080908@mandrakesoft.com>
Date: Mon, 11 Mar 2002 21:37:23 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Bill Davidsen <davidsen@tmr.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] My AMD IDE driver, v2.7
In-Reply-To: <Pine.LNX.4.33.0203111829550.1153-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>
>On Mon, 11 Mar 2002, Jeff Garzik wrote:
>
>>If filtering is done, I agree the filter feature is disable-able if the
>>kernel builder / sysadmin desires such.  Disable the filter by default,
>>if that's your fancy.  But let us filter.  :)
>>
>
>BUT WHAT THE HELL IS THE POINT?
>
>Don't you get that? If the sysadmin can turn the filtering off, so can any
>root program. And your worry seems to be the CRM kind of disk locking
>utility which most _definitely_ would do exactly that if it is as evil as
>you think it is.
>
dynamic filtering sucks, I agree, and I am not arguing for that.

>And if you hardcode the filtering at compile-time in the kernel, that
>means that you've now painted yourself into the corner that you already
>seemed to admit was not a good idea - the same way it's not a good idea
>for network filtering.
>
No, I think hardcoding at compile time is useful here.

It serves to encourage openness, nobody is forced to use it, and it 
provides an additional layer of protection for those that choose to use 
it.  That is the point.  It's a choice, and you don't have to enable it 
in your kernel.  But there seems to be enough demand that it should be 
at least an option.

    Jeff





