Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313773AbSE2REC>; Wed, 29 May 2002 13:04:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313867AbSE2REB>; Wed, 29 May 2002 13:04:01 -0400
Received: from [195.63.194.11] ([195.63.194.11]:14344 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313773AbSE2REA>; Wed, 29 May 2002 13:04:00 -0400
Message-ID: <3CF4FC52.7080406@evision-ventures.com>
Date: Wed, 29 May 2002 18:05:38 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Gerald Champagne <gerald@io.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.18 IDE 73
In-Reply-To: <1022680784.2945.24.camel@wiley> <3CF4D19F.9080402@evision-ventures.com> <20020529183343.A19610@ucw.cz> <1022694938.9255.269.camel@irongate.swansea.linux.org.uk> <20020529190135.A19776@ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> On Wed, May 29, 2002 at 06:55:38PM +0100, Alan Cox wrote:
> 
> 
>>>Also for black/whitelists. And we're going to need those, though maybe
>>>the current data in them is not worth much.
>>
>>I'm hopeful they still are. The early drives with DMA problems won't
>>have changed over time, and I've been updating the others when I get
>>data from vendors. Promise for example recently sent me a couple to add
> 
> 
> The early drives haven't changed, but the drivers for the controllers
> which they were tested on changed (or will change soon). Namely the
> lists of PIO mode limits were wrong very often. This is mainly because
> some of the (now almost unused) drivers program the timings incorrectly
> into the controller registers.
> 
> I can't say much about the more recent entries, except for that it'd be
> nice to add a date when the entry was last tested and with what result
> to each of them over time.

And plese note as well that we don't need the whole id struct, but just
the name of the drive as well. Which is much less of a hassle anyway.

