Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318275AbSIOW3O>; Sun, 15 Sep 2002 18:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318277AbSIOW3O>; Sun, 15 Sep 2002 18:29:14 -0400
Received: from web13201.mail.yahoo.com ([216.136.174.186]:65106 "HELO
	web13201.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S318275AbSIOW3L>; Sun, 15 Sep 2002 18:29:11 -0400
Message-ID: <20020915223408.51335.qmail@web13201.mail.yahoo.com>
Date: Sun, 15 Sep 2002 15:34:08 -0700 (PDT)
From: Srinivas Chavva <chavvasrini@yahoo.com>
Subject: Re: Configuring kernel
To: linux-kernel@vger.kernel.org
In-Reply-To: <3D83A943.3010200@davehollis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I tried to execute the command "make xconfig" I
got the following output

rm -f include/asm
(cd include; ln -sf asm -i386 asm)
make -C scripts knconfig.tk
make: *** scripts: No such file or directory. Stop.
make: *** [xconfig] Error 2

When I executed the command 'rpm -q ncurses
ncurses-devel'  I got the following output

ncurses-5.2-8
ncurses-devel-5.2-8

Could you please help me to fix the error. 
Thanking You.
Regards,
Srinivas Chavva

David T Hollis wrote:

>>I seem to remember either the early RH 7.x series or
6.x series did not 
>>necessarily install ncurses by default, thus make
menuconfig did not 
>>run.  If you did a very slim install, you may not
have the right 
>>libraries to do what you need.  Do an 'rpm -q
ncurses ncurses-devel' 
>>and 
>>see what you get.  If either is not found, make
menuconfig will not 
>>run.

Adam Jaskiewicz wrote:

>>I downloaded the sofware and opened it in the
/usr/src
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
>What errors did you get? We need to know what the
errors are to help 
you.
>
>  
>
>>When I used the command uname -i I still was getting
>>the kernel version as 2.4.2.
>>I do not know why this error is coming.
>>    
>>
>
>This is not an error. If you did not install a new
kernel and reboot 
your 
>computer with the new kernel, uname will still have
the same kernel 
version. 
>Once you have properly configured, compiled and
installed the kernel 
and its 
>modules, you reboot the computer to apply the new
kernel. Then uname 
will 
>give you the new version.
>
>  
>



-
To unsubscribe from this list: send the line
"unsubscribe linux-kernel" 
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at 
http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

__________________________________________________
Do you Yahoo!?
Yahoo! News - Today's headlines
http://news.yahoo.com
