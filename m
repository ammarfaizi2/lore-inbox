Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314433AbSEBNr0>; Thu, 2 May 2002 09:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314439AbSEBNrZ>; Thu, 2 May 2002 09:47:25 -0400
Received: from [195.63.194.11] ([195.63.194.11]:45324 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S314433AbSEBNrY>; Thu, 2 May 2002 09:47:24 -0400
Message-ID: <3CD134B6.6090504@evision-ventures.com>
Date: Thu, 02 May 2002 14:44:38 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dwmw2@infradead.org
Subject: Re: Linux 2.5.7
In-Reply-To: <Pine.LNX.4.33.0203181243210.10517-100000@penguin.transmeta.com> <3CD0FC0E.5020108@evision-ventures.com> <20020502152237.H16935@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Dave Jones napisa?:
> On Thu, May 02, 2002 at 10:42:54AM +0200, Martin Dalecki wrote:
> 
>  > -   struct request *current_request;
>  > +   struct request *req;
>  >     unsigned int res = 0;
>  >     struct mtd_info *mtd;
> 
> This gratuitous change makes life a lot more irritating when bring
> forward fixes from 2.4. They now need an extra pass to go through
> and munge all the varnames. Or are you proposing the same change
> for 2.4 ?
>  

No I was consciuous: I just saw some macro preprocessing
clashes.

