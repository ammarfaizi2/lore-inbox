Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275270AbRJYQsO>; Thu, 25 Oct 2001 12:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275278AbRJYQr4>; Thu, 25 Oct 2001 12:47:56 -0400
Received: from kitkat.hotpop.com ([204.57.55.30]:29202 "HELO kitkat.hotpop.com")
	by vger.kernel.org with SMTP id <S275270AbRJYQrn>;
	Thu, 25 Oct 2001 12:47:43 -0400
Message-ID: <3BD841B7.5060405@toughguy.net>
Date: Thu, 25 Oct 2001 11:45:43 -0500
From: Lost Logic <lostlogic@toughguy.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: kernel compiler
In-Reply-To: <E15wmgp-0005E8-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

GCC 3.0 Produces slower code, eh?  I was of the understanding that it 
contained many more optimizations than previous versions...???

Any way, I've been able to run my system based entirely on a fairly 
recent GCC CVS-3.02 snapshot, including kernels, and everything EXCEPT 
for glibc which is specifically incompatible according to the GNU folks.  

By way of information however, neither of the GCC 3.0 releases (3.0.0 or 
3.0.1) work at all on my system, and I cannot get a kernel to function 
at better than -O2 (not that I could get that to work in 2.95.* or 
2.96.* either).

--Lost Logic (Brandon Low)

Alan Cox wrote:

>>>At the moment, gcc3 doesn't work too well with the kernel, and you won't
>>>get any large benefit.
>>>
>>I use gcc3 to compile anything and everything I need.  With the
>>exception of "multi-line literal complaints", my kernel compiles fine.
>>
>>Is there anything that I should know?
>>
>
>Mostly that gcc 3.0 generally produces slower code. I've had a couple of 
>noticed glitches with -ac but those have workarounds in the tree now
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>




