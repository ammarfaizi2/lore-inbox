Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275863AbRI1Hjo>; Fri, 28 Sep 2001 03:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275964AbRI1Hje>; Fri, 28 Sep 2001 03:39:34 -0400
Received: from fe010.worldonline.dk ([212.54.64.195]:59657 "HELO
	fe010.worldonline.dk") by vger.kernel.org with SMTP
	id <S275863AbRI1HjX>; Fri, 28 Sep 2001 03:39:23 -0400
Message-ID: <3BB427F1.5070403@eisenstein.dk>
Date: Fri, 28 Sep 2001 09:34:09 +0200
From: Jesper Juhl <juhl@eisenstein.dk>
Organization: Eisenstein
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16 i586; en-US; m18) Gecko/20010131 Netscape6/6.01
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        Thomas Hood <jdthood@yahoo.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: OOM killer
In-Reply-To: <E15mkLX-0005S3-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>>> shed:~# echo 0 >/proc/sys/vm/overcommit_memory
>>> shed:~# cat /proc/sys/vm/overcommit_memory
>>> 0
>> 
>> ahh, I see. Well, you live and learn ;)
>> 
>> I think I've got to do my research better before writing mails to lkml.
> 
> 
> In part.
> 
> The option you want is '2' which isnt implemented 8)
> 
> 0	-	I don't care
> 1	-	Use heuristics to guesstimate avoiding overcommit


Thank you for that info :)

I wrote a small test program that allocated memory in increasingly 
larger chunks, and I saw no major difference with a setting of "0" or 
"1", it seemed both settings allowed my program to allocate exactely the 
same amount of mem before ENOMEM was returned (I can send the test 
program on request).

I'll be looking forward to a setting of "2" becomming available :)


Best regards
Jesper Juhl

