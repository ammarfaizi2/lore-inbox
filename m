Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312775AbSCVSCh>; Fri, 22 Mar 2002 13:02:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312778AbSCVSC1>; Fri, 22 Mar 2002 13:02:27 -0500
Received: from relay1.soft.net ([164.164.128.17]:36562 "EHLO cyclops.soft.net")
	by vger.kernel.org with ESMTP id <S312775AbSCVSCS>;
	Fri, 22 Mar 2002 13:02:18 -0500
Message-ID: <91A7E7FABAF3D511824900B0D0F95D10136FA5@BHISHMA>
From: Abdij Bhat <Abdij.Bhat@kshema.com>
To: "'kferreir@esscom.com'" <kferreir@esscom.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Linux Kernel Hangs
Date: Fri, 22 Mar 2002 22:20:35 +0530
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 Sorry I missed to write that I have done the /sbin/lilo -v after editing
lilo.conf.

Regards,
Abdij

-----Original Message-----
From: Kurt Ferreira [mailto:kferreir@esscom.com]
Sent: Friday, March 22, 2002 4:34 PM
To: Abdij Bhat
Subject: Re: Kernel Upgrade Hangs!



On Fri, 22 Mar 2002, Abdij Bhat wrote:

> Hi,
>  I am trying to build the 2.4.17 Kernel and upgrade my existing 2.4.7-10
Red
> Hat Linux System. Here is the procedure I followed ( based on Red Hat
> Documentation on the same ):
> 
> 1. tar -xvzf linux-2.4.17.tar.gz
> 2. cd linux
> 3. make mkproper
> 4. make menuconfig
> 5.make dep 
> 6. make clean 
> 7. make bzImage 
> 8. make modules 
> 9. make modules_install 
> 10. cp /usr/src/linux-2.4.17/arch/i386/boot/bzImage /boot/vmlinuz-2.4.17 
> 11. cp /usr/src/linux-2.4.17/System.map /boot/System.map-2.4.17 
> 12. cd /boot rm System.map ln -s System.map-2.4.17 System.map 
> 13. mkinitrd /boot/initrd-2.4.17.img 2.4.17 
> 14. Modify the /etc/lilo.conf to add
> 		image=/boot/vmlinuz-2.4.17
> 		label=linux-Mine
> 		root=/dev/hda1
> 		initrd=/boot/initrd-2.4.17
> 		read-only
>

Did you run /sbin/lilo here?  You must
 
>  Now when i reboot and select the linux-Mine option the screen displays
> 		Loading vmlinuz-2.4.7
> 		Uncompressing Linux... Ok, booting the kernel
> 
>  and then HANGS!!!!!!
> 
>  What might be the problem. I have followed the instruction to the T. I
> tried without the initrd option too. I have enabled the RAM diak
> option/disabled it....
>  
>  Please help me out on the issue.
> 
> Thanks and Regards,
> Abdij
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
