Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267196AbRHJMTI>; Fri, 10 Aug 2001 08:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267248AbRHJMS6>; Fri, 10 Aug 2001 08:18:58 -0400
Received: from www.grips.com ([62.144.214.31]:24589 "EHLO grips_nts2.grips.com")
	by vger.kernel.org with ESMTP id <S267196AbRHJMSp>;
	Fri, 10 Aug 2001 08:18:45 -0400
Message-ID: <3B73D1E9.9020800@grips.com>
Date: Fri, 10 Aug 2001 14:22:01 +0200
From: jury gerold <geroldj@grips.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010803
X-Accept-Language: de-at, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Thodoris Pitikaris <thodoris@cs.teiher.gr>, linux-kernel@vger.kernel.org
Subject: Re: is this a bug?
In-Reply-To: <3B6FD644.7020409@cs.teiher.gr> <3B716E0A.8030005@grips.com> <m1g0b0th21.fsf@frodo.biederman.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric

The CPU is a 1.1GHz tbird 200MHz FSB and i am running it this way.
The motherboard can do 100 and 133 MHz but i run
the SDRAM at 100MHz from the beginning, since i have seen lot's
of boards with memory problems and i wanted to be on the good side.
Both, the old 128MB and the new 256MB SDRAM where sold as PC133.
It is a single DIMM in both cases.

When i started to sue the SDRAM for the trouble i checked the SPD and found
the 128MB-PC133 was actually a PC100 with a few steps towards PC66 
(major brand).
So i tried a new one that, at least from the SPD, is a real PC133 and 
suddenly ...

I have tried to kill it

kernel 2.4.7-xfs from cvs at the moment
athlon optimisations
UDMA on ide0 and ide1
2 harddrives, 1 cdrom, 1 cd/rw

since then, but it works, works, works.


This weekend does not see me at home.
I will send the timings on sunday/monday.

What do you expect to get out of this ?

Gerold


Eric W. Biederman wrote:

>jury gerold <geroldj@grips.com> writes:
>
>>I have the same motherboard, same chipset, same CPU and the same crash.
>>No memory test cpu burn UDMA on/off, replace or remove of components
>>did any good.
>>Then i replaced the 100mhz SDRAM with a 133mhz and it is 100 % stable since
>>then.
>>
>>No matter which compiler, kernel version, cputype.
>>It simply works now.
>>
>
>Do you happen to have the SDRAM timings of the two sets of DIMMS?
>It would be interesting to see what changed besides the clock speed on
>the DIMMS.  I'm assuming your PC133 DIMMs are running at at 133Mhz,
>and you aren't over clocking anything.
>
>Eric
>


