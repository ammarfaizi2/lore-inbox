Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311675AbSCNRAh>; Thu, 14 Mar 2002 12:00:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311673AbSCNRA1>; Thu, 14 Mar 2002 12:00:27 -0500
Received: from inet-mail1.oracle.com ([148.87.2.201]:15295 "EHLO
	inet-mail1.oracle.com") by vger.kernel.org with ESMTP
	id <S311675AbSCNRAT>; Thu, 14 Mar 2002 12:00:19 -0500
Message-ID: <3C90D73F.3080003@oracle.com>
Date: Thu, 14 Mar 2002 18:00:47 +0100
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Support Services
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020212
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
CC: tyketto@wizard.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.6: make xconfig croaks in with sound/core/Config.in
In-Reply-To: <200203141611.RAA15178@green.mif.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrzej Krzysztofowicz wrote:
>>        Short, but sweet:
>>
>>root@bellicha:/usr/src/linux# head -10 Makefile
>>VERSION = 2
>>PATCHLEVEL = 5
>>SUBLEVEL = 6
>>EXTRAVERSION =
>>
> [...]
> 
>>gcc -o tkparse tkparse.o tkcond.o tkgen.o
>>cat header.tk >> ./kconfig.tk
>>./tkparse < ../arch/i386/config.in >> kconfig.tk
>>sound/core/Config.in: 4: can't handle dep_bool/dep_mbool/dep_tristate condition
>>
>   ^^^^^^^^^^^^^^^^^^^^^^^
> Error location seems to be clear.
> Forgotten dependency ?

I simply added $CONFIG_SND after that and two more lines.

It compiles :)


--alessandro

  "time is never time at all / you can never ever leave
    without leaving a piece of youth"
                    (Smashing Pumpkins, "Tonight, tonight")

