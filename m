Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313773AbSFQODE>; Mon, 17 Jun 2002 10:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313867AbSFQODD>; Mon, 17 Jun 2002 10:03:03 -0400
Received: from [195.63.194.11] ([195.63.194.11]:48132 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313773AbSFQODD> convert rfc822-to-8bit; Mon, 17 Jun 2002 10:03:03 -0400
Message-ID: <3D0DEBF4.5080209@evision-ventures.com>
Date: Mon, 17 Jun 2002 16:02:28 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0.0) Gecko/20020611
X-Accept-Language: pl, en-us
MIME-Version: 1.0
To: Lionel Bouton <Lionel.Bouton@inet6.fr>
CC: Zwane Mwaikambo <zwane@linux.realnet.co.sz>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.20 hardlock w/ hdparm
References: <Pine.LNX.4.44.0206150948140.30400-100000@netfinity.realnet.co.sz> <3D0DE4CC.9010901@inet6.fr>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik Lionel Bouton napisa³:
> Zwane Mwaikambo wrote:
> 
>> Hi Lionel, Martin,
>> 2.5.20, hdparm + IDE deadlocks on my testbox
>>  
>>
> 
> I don't follow 2.5 dev (yet). I merely follow Andre's work on 2.4 and 
> code a new chipset capabilities detection code in order to support newer 
> chipsets.
> Is the v0.13 driver driver already forward ported to 2.5 by somebody ?

Yeep. In fact my main devel box is based on SiS 635...

> If there's a need (some 2.5 developpers needing a more uptodate driver 
> and uncomfortable with forward porting IDE chipset drivers), I'll do it...

Please just keep an eye on it. The internal interface for host chip
setup should now be much more... well palatable :-).

> Hum, 486 SiS chipsets might bring pain to me also...
> I've received several bugreports for old SiS IDE chipset (ie pre ATA66) 
> that I couldn't solve without disabling the SiS driver or passing 
> "ide=nodma". I've triple-checked the specs and couldn't see the problem.

