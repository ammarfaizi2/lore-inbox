Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317520AbSINVUe>; Sat, 14 Sep 2002 17:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317525AbSINVUe>; Sat, 14 Sep 2002 17:20:34 -0400
Received: from 653272hfc53.tampabay.rr.com ([65.32.72.53]:5651 "EHLO
	bender.davehollis.com") by vger.kernel.org with ESMTP
	id <S317520AbSINVUd>; Sat, 14 Sep 2002 17:20:33 -0400
Message-ID: <3D83A943.3010200@davehollis.com>
Date: Sat, 14 Sep 2002 17:25:23 -0400
From: David T Hollis <dhollis@davehollis.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020825
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Srinivas Chavva <chavvasrini@yahoo.com>
Subject: Re: Configuring kernel
References: <20020913184715.62063.qmail@web13205.mail.yahoo.com> <02091315021800.01433@aragorn>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I seem to remember either the early RH 7.x series or 6.x series did not 
necessarily install ncurses by default, thus make menuconfig did not 
run.  If you did a very slim install, you may not have the right 
libraries to do what you need.  Do an 'rpm -q ncurses ncurses-devel' and 
see what you get.  If either is not found, make menuconfig will not run.

Adam Jaskiewicz wrote:

>>I downloaded the sofware and opened it in the /usr/src
>>directory. I did the following
>>1. unzipped the tar file
>>2. mv linux linux-2.4.16
>>3 ln -s linux-2.4.16 linux
>>4. changed to linux directory and issued the command
>>make mproper.
>>Then when I issued the command make xconfig I was
>>getting errors. I got similar errors when I tried to
>>use the following commands make menuconfig, make
>>config.
>>    
>>
>
>What errors did you get? We need to know what the errors are to help you.
>
>  
>
>>When I used the command uname -i I still was getting
>>the kernel version as 2.4.2.
>>I do not know why this error is coming.
>>    
>>
>
>This is not an error. If you did not install a new kernel and reboot your 
>computer with the new kernel, uname will still have the same kernel version. 
>Once you have properly configured, compiled and installed the kernel and its 
>modules, you reboot the computer to apply the new kernel. Then uname will 
>give you the new version.
>
>  
>



