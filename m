Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289732AbSAKAeH>; Thu, 10 Jan 2002 19:34:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289805AbSAKAd5>; Thu, 10 Jan 2002 19:33:57 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:31736 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S289732AbSAKAdt>; Thu, 10 Jan 2002 19:33:49 -0500
Message-ID: <3C3E32EB.7040203@redhat.com>
Date: Thu, 10 Jan 2002 19:33:47 -0500
From: Doug Ledford <dledford@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020103
X-Accept-Language: en-us
MIME-Version: 1.0
To: reddog83@chartermi.net
CC: camel_3@hotmail.com, linux-kernel@vger.kernel.org
Subject: Re: i810_audio
In-Reply-To: <auto-000047665933@front2.chartermi.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

reddog83 wrote:

> Doug do you still have the i810 audio version 0.18
> Also v0.19 has unresolved symbols :
> ./i810_audio.o: unresolved symbol __global_cli
> ./i810_audio.o: unresolved symbol kernel_flag
> ./i810_audio.o: unresolved symbol synchronize_irq
> ./i810_audio.o: unresolved symbol __global_save_flags
> ./i810_audio.o: unresolved symbol __global_restore_flags


This isn't an i810_audio.c problem.  You've somehow changed your config from 
smp to non-smp or vice versa and not recompiled the rest of the kernel yet 
or something like that.  Besides, 0.20 is on my site now and it should solve 
the last of the lockups some people were seeing with artsd.


> i686 566 Celeron kernel 2.4.17 
> If you do will you send me v0.18 so that I may have sound again thank you.
> (I lost it so that is why I'm asking)
> Victor
> 
>>Does anybody still have the i810_audio version 0.18 if so please send me the 
>>driver becuase Doug updated his link for version 0.19
>>Thank you in advance Victor
>>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 



-- 

  Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
       Please check my web site for aic7xxx updates/answers before
                       e-mailing me about problems

