Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129469AbQKGVHI>; Tue, 7 Nov 2000 16:07:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129413AbQKGVG7>; Tue, 7 Nov 2000 16:06:59 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:46086 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129308AbQKGVGt>; Tue, 7 Nov 2000 16:06:49 -0500
Message-ID: <3A086D4C.56C5D6AD@timpanogas.org>
Date: Tue, 07 Nov 2000 13:59:56 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Anil kumar <anils_r@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Installing kernel 2.4
In-Reply-To: <20001107205233.13661.qmail@web6102.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Anil kumar wrote:
> 
> Hi ,
>   I installed Red Hat 7.0, I am able to find the
>   linux-2.2.16 in /usr/src
> 
>   These are the following steps I did to install
> kernel 2.4:
> 
>   cd /usr/src
>   #rm -r linux
>    # rm -rf linux-2.2.16
>    #tar -xvf  linux-2.4.0-test9.tar
> 
>   #cd /usr/src
> #ls
>  linux
>  redhat
>  #mv  linux linux-2.4.0-test9
>  #ln -s linux-2.4.0-test9 linux
> 
>   #ls
>    linux->linux-2.4.0-test9
>    linux-2.4.0-test9
>    redhat
> 
>   #cd /usr/src/linux
>   #make xconfig
>   I just save & exit without changing the
> configuration.
>   #make dep
>   #make clean
>   #make bzImage
>   #make modules
>   #make modules_install
> 
>   I find that System.map is mapped to 2.4.0, ie.. new
>   System-2.4.0-test9.map is created
> 
>   #cd /boot
>   #ls
>   #vmlinuz->vmlinuz-2.4.0-test9
>   #cd /usr/src/linux/arch/i386/boot
>   #cp bzImage /boot/vmlinuz
> 
>   #vi /etc/lilo.conf
>   changed image from image = /boot/vmlinuz-2.2.16-22


How about making this line match the name of the copied kernel (you
copied it as 
/boot/vmlinuz so thi should be image = /boot/vmlinuz

Jeff

> to
>   image = /boot/vmlinuz-2.4.0-test9
> 
>   #lilo
>    linux
>     dos
> 
>   when I boot linux
> 
>   The system hangs after messages:
>   loading linux......
>   uncompressing linux, booting linux kernel OK.
> 
>   The System hangs here.
> 
>   Please let me know where I am wrong
> 
>   with regards,
>   Anil
> 
> __________________________________________________
> Do You Yahoo!?
> Thousands of Stores.  Millions of Products.  All in one Place.
> http://shopping.yahoo.com/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
