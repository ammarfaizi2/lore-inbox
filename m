Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267244AbTCEPzv>; Wed, 5 Mar 2003 10:55:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267260AbTCEPzv>; Wed, 5 Mar 2003 10:55:51 -0500
Received: from pechkin.minfin.bg ([212.122.164.10]:41671 "EHLO
	pechkin.minfin.bg") by vger.kernel.org with ESMTP
	id <S267244AbTCEPzs>; Wed, 5 Mar 2003 10:55:48 -0500
Message-ID: <3E66203C.7070504@minfin.bg>
Date: Wed, 05 Mar 2003 18:05:16 +0200
From: Kostadin Karaivanov <larry@minfin.bg>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030112
X-Accept-Language: en-us, en, bg
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: ipsec-tools 0.1 + kernel 2.5.64
References: <3E65E45E.8090401@minfin.bg>
In-Reply-To: <3E65E45E.8090401@minfin.bg>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kostadin Karaivanov wrote:

>> Hi,
>>
>> both manual keying and automatic keying with racoon (pre-shared secret)
>> are working fine. No need to patch or modify anything. I tried only 
>> ipv4.
>>
>> But: don't "setkey -DP" while racoon is running, it crashes
>> my machine. Sorry, could not get any details.
>
>>
>> Andreas
>
> BTW "ipsec-tools 0.1" from where ??? 

   If you mention www.sf.net/projects/ipsec-tools
   they does not compiles for me I cot following error

grabmyaddr.c:69:1: warning: "HAVE_GETIFADDRS" redefined
<command line>:1:1: warning: this is the location of the previous definition
grabmyaddr.c:88: redefinition of `struct ifaddrs'
grabmyaddr.c:200: warning: static declaration for `getifaddrs' follows 
non-static
grabmyaddr.c:254: warning: static declaration for `freeifaddrs' follows 
non-static
make[3]: *** [grabmyaddr.o] Error 1
make[3]: Leaving directory `/usr/src/ipsec-tools-0.1/src/racoon'
make[2]: *** [all-recursive] Error 1
make[2]: Leaving directory `/usr/src/ipsec-tools-0.1/src'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/usr/src/ipsec-tools-0.1'
make: *** [all] Error 2

  I can provide additional info if needed (gcc-3.2.2)

>
>
> wwell Larry
>
>


