Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314377AbSDZWar>; Fri, 26 Apr 2002 18:30:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314378AbSDZWaq>; Fri, 26 Apr 2002 18:30:46 -0400
Received: from [195.63.194.11] ([195.63.194.11]:6667 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S314377AbSDZWap>;
	Fri, 26 Apr 2002 18:30:45 -0400
Message-ID: <3CC9C666.8020801@evision-ventures.com>
Date: Fri, 26 Apr 2002 23:28:06 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Sebastian Droege <sebastian.droege@gmx.de>
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.10 IDE 42
In-Reply-To: <1019549894.1450.41.camel@turbulence.megapathdsl.net>	<3CC7E358.8050905@evision-ventures.com>	<20020425172508.GK3542@suse.de>	<20020425173439.GM3542@suse.de>	<aa9qtb$d8a$1@penguin.transmeta.com>	<3CC904AA.7020706@evision-ventures.com> <20020426181049.5eb31b05.sebastian.droege@gmx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Sebastian Droege napisa?:
> On Fri, 26 Apr 2002 09:41:30 +0200
> Martin Dalecki <dalecki@evision-ventures.com> wrote:
> 
> Hi,
> 
> @@ -584,27 +585,25 @@
>  			drive->failures = 0;
>  		} else {
>  			drive->failures++;
> +			char *msg = "";
> 
> My compiler won't compile that ;)
> Declare msg after the function's beginning and it compiles fine

Well it doesn't has to be the function it sufficient to be
the beginng of a block. However this is puzzling me,
becouse the gcc-3.1 snap eats the above just like if it
where a C++ complier!!!

Thank you for pointing out.

