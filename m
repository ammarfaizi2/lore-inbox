Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262199AbTCRNo7>; Tue, 18 Mar 2003 08:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262228AbTCRNo7>; Tue, 18 Mar 2003 08:44:59 -0500
Received: from curry.ceng.metu.edu.tr ([144.122.171.200]:37570 "EHLO
	curry.ceng.metu.edu.tr") by vger.kernel.org with ESMTP
	id <S262199AbTCRNo6>; Tue, 18 Mar 2003 08:44:58 -0500
Message-ID: <3E772604.5050604@ceng.metu.edu.tr>
Date: Tue, 18 Mar 2003 15:58:28 +0200
From: Mehmet Ersan TOPALOGLU <mersan@ceng.metu.edu.tr>
Reply-To: mersan@ceng.metu.edu.tr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: process resident in memory
References: <3E76BCA9.3060902@ceng.metu.edu.tr> <20030318134238.GA22953@riesen-pc.gr05.synopsys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Riesen wrote:
> Mehmet Ersan TOPALOGLU, Tue, Mar 18, 2003 07:28:57 +0100:
> 
>>I am a newbie in kernel programming.
>>And am sorry if something related previously asked.
>>I wonder if it is possible to following situation is possible or not.
>>
>>let say i have a user process p1.
> 
> 
> That (user process) has nothing to do with kernel programming.
> 
> 
>>p1 does some malloc, and file i/o etc
>>i initiate it during boot time.
>>it stays resident in memory as if kernel it self (??)
> 
> 
> no. It is as long resident as it wish. Or until it is killed.
> 
> 
>>and its priority is very very high
> 
> 
> it is irrelevant.
> 

Well i guess i couldn't explain what i really meant.
Thing is that i am trying to change kernel memory management 
specifically for one user process only.
i.e if kernel sees this process it will treat it in a different manner.
It won't let it to be swapped and give a very high priority to it.
I just wondered the possiblity of this.
Sorry for my poor english


-- 
- mersan
     mersan@ceng.metu.edu.tr
     mersan@metu.edu.tr

	LIFE WORTH LIVING WITHOUT YOU?

