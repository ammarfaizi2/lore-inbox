Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314477AbSD1T7D>; Sun, 28 Apr 2002 15:59:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314480AbSD1T7B>; Sun, 28 Apr 2002 15:59:01 -0400
Received: from [195.63.194.11] ([195.63.194.11]:37382 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S314477AbSD1T67>; Sun, 28 Apr 2002 15:58:59 -0400
Message-ID: <3CCC45D7.2030401@evision-ventures.com>
Date: Sun, 28 Apr 2002 20:56:23 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: zlatko.calusic@iskon.hr
CC: Jarno Paananen <jpaana@s2.org>,
        Pierre Rousselet <pierre.rousselet@wanadoo.fr>,
        lkml <linux-kernel@vger.kernel.org>, mingo@elte.hu
Subject: Re: 2.5.9 - HPT366 ide unexpected interrupts
In-Reply-To: <3CC5BAA3.3080705@wanadoo.fr> <m3u1q0smou.fsf@kalahari.s2.org> <878z77er9m.fsf@atlas.iskon.hr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Zlatko Calusic napisa?:
> Jarno Paananen <jpaana@s2.org> writes:
> 
> 
>>Pierre Rousselet <pierre.rousselet@wanadoo.fr> writes:
>>
>>| PIII 650/Abit BE6 HPT366(ide2, ide3)
>>| 
>>| dmesg gives 482 times the same line :
>>| ide: unexpected interrupt 0 11
> 
> 
> I'm having the same problems on dual PIII (VIA chipset) with addon
> Promise IDE card:
> 
> Apr 24 19:34:51 atlas kernel: ide: unexpected interrupt 1 11
> 
> Lots of those...
> 
> Looks like it favors additional IDE interfaces. As system appears to
> behave sanely, modulo flooded logs, I decided to comment the printk
> for the time being.

That's fine and it will be gone in 2.5.11. The message is

> Ingo, does it have anything to do with your interrupt balancing code?
> If you need additional testing, let me know.

No no no. It's really harmless. It is affecting add on interfaces becouse
they are likely to share interrupts with other devices.


