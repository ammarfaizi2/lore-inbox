Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272593AbRHaDHg>; Thu, 30 Aug 2001 23:07:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272594AbRHaDH1>; Thu, 30 Aug 2001 23:07:27 -0400
Received: from cpe-24-221-114-147.az.sprintbbd.net ([24.221.114.147]:1418 "EHLO
	localhost.digitalaudioresources.org") by vger.kernel.org with ESMTP
	id <S272593AbRHaDHP>; Thu, 30 Aug 2001 23:07:15 -0400
Message-ID: <3B8EFF67.9010409@digitalaudioresources.org>
Date: Thu, 30 Aug 2001 20:07:19 -0700
From: David Hollister <david@digitalaudioresources.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010808
X-Accept-Language: en-us
MIME-Version: 1.0
To: Jan Niehusmann <jan@gondor.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Athlon doesn't like Athlon optimisation?
In-Reply-To: <20010831044247.B811@gondor.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Niehusmann wrote:
> I have a computer with a duron 600 which doesn't like current athlon
> optimised kernels: It runs fairly well with an old 2.4.0-test7 kernel
> (but I had some unexplained crashes during the last months),
> but crashes after a few minutes after booting 2.4.9-ac3 or 2.4.7. 
> 
> If I don't build the kernels for athlon, but for i386 only, the 
> system seems to be stable. (Not tested for more than 20 minutes, 
> but definitely longer than the athlon optimised kernel was able to run)
> 
> Does anybody know these symptoms and has an idea what may be wrong?
> Is it likely to be a broken CPU? 
> The board is an A7V with the infamous via chipset, but I don't think
> this looks like the typical via problems, does it?
> 
> Jan

This has apparently been a source of frustration for many an Athlon user, myself 
included.  I can't even get my system to finish the init process before it 
oopses and locks up on me.

It seems to work somewhat better for some if you set your BIOS to the 
conservative settings, but that didn't help me.  I have an Epox 8KTA3+ (Via 
KT133A) w/ a 1.4GHz Athlon and 512MB memory.  If you can't get it to work that 
way, just stick with the K6 setting.  The point is, your hardware is likely fine 
(fine being relative, I suppose)
If there are other tricks, I'm all ears.

-- 
David Hollister
Driversoft Engineering:  http://devicedrivers.com
Digital Audio Resources: http://digitalaudioresources.org

