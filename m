Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262399AbTCROIS>; Tue, 18 Mar 2003 09:08:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262404AbTCROIS>; Tue, 18 Mar 2003 09:08:18 -0500
Received: from curry.ceng.metu.edu.tr ([144.122.171.200]:59011 "EHLO
	curry.ceng.metu.edu.tr") by vger.kernel.org with ESMTP
	id <S262399AbTCROIR>; Tue, 18 Mar 2003 09:08:17 -0500
Message-ID: <3E772B7D.3010309@ceng.metu.edu.tr>
Date: Tue, 18 Mar 2003 16:21:49 +0200
From: Mehmet Ersan TOPALOGLU <mersan@ceng.metu.edu.tr>
Reply-To: mersan@ceng.metu.edu.tr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: process resident in memory
References: <3E76BCA9.3060902@ceng.metu.edu.tr> <20030318134238.GA22953@riesen-pc.gr05.synopsys.com> <3E772604.5050604@ceng.metu.edu.tr> <Pine.LNX.4.53.0303180901001.26924@chaos>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Yes, but he didn't know what was available in user-mode.
> 
> 
> 
>>Well i guess i couldn't explain what i really meant.
>>Thing is that i am trying to change kernel memory management
>>specifically for one user process only.
>>i.e if kernel sees this process it will treat it in a different manner.
>>It won't let it to be swapped and give a very high priority to it.
>>I just wondered the possiblity of this.
>>Sorry for my poor english
>>
> 
> 
> You want to execute:
> 
> man mlockall
> man nice

first of all i don't have chance to modify the process' code.
the thing mlockall does is exactly what i am trying to do
(at least a part of it).

So your answer is he couldn't know about user-mode so it is not possible.
What if kernel forks that process or somehow its process id is informed 
to kernel?





-- 
- mersan
     mersan@ceng.metu.edu.tr
     mersan@metu.edu.tr

	LIFE WORTH LIVING WITHOUT YOU?

