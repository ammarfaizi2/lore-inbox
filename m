Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289012AbSBMWTB>; Wed, 13 Feb 2002 17:19:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289014AbSBMWSx>; Wed, 13 Feb 2002 17:18:53 -0500
Received: from ip68-3-107-226.ph.ph.cox.net ([68.3.107.226]:59040 "EHLO
	ip68-3-107-226.ph.ph.cox.net") by vger.kernel.org with ESMTP
	id <S289012AbSBMWSq>; Wed, 13 Feb 2002 17:18:46 -0500
Message-ID: <3C6AE602.3080708@candelatech.com>
Date: Wed, 13 Feb 2002 15:17:38 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: "Richard B. Johnson" <root@chaos.analogic.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: How to check the kernel compile options ?
In-Reply-To: <Pine.LNX.3.96.1020213163646.12448B-100000@gatekeeper.tmr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Bill Davidsen wrote:

> On Wed, 13 Feb 2002, Richard B. Johnson wrote:
> 
> 
>>The advantage, of course is that if you are executing the kernel,
>>it can give you all the information necessary to recreate a
>>new one from the sources because its .config is embeded into
>>itself. Once you have the ".config" file, you just do `make oldconfig`
>>and you are home free.
>>
> 
> But it does no such thing! You not only need the config file, you need the
> source. So you now need to add to the kernel the entire source tree from
> which it was built, or perhaps just a diff file from a kernel.org source,
> which you will suitably compress, of course.


Heh, if you want to exactly copy your existing kernel, just use the
'cp' command!  Saving the config is more useful for those of us who
want to build a new kernel with new source that is *similar* to some
existing kernel.  Also, when an interesting bug (ie panic) occurs,
we can extract the .config automagically and send it along with
the ksymoops decode to the maintainers.  It's always easier to reproduce
the bug if you have the .config to the kernel that produced it.

Remember, you do not have to enable the feature.

Enjoy,
Ben



-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


