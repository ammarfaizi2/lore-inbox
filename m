Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312750AbSCVQcl>; Fri, 22 Mar 2002 11:32:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312751AbSCVQcb>; Fri, 22 Mar 2002 11:32:31 -0500
Received: from firewall.oeone.com ([216.191.248.101]:35844 "HELO
	mail.oeone.com") by vger.kernel.org with SMTP id <S312750AbSCVQcV>;
	Fri, 22 Mar 2002 11:32:21 -0500
Message-ID: <3C9B5C94.9020200@oeone.com>
Date: Fri, 22 Mar 2002 11:32:20 -0500
From: Masoud Sharbiani <masouds@oeone.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020310
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Abdij Bhat <Abdij.Bhat@kshema.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Kernel Upgrade Hangs!
In-Reply-To: <91A7E7FABAF3D511824900B0D0F95D10136FA4@BHISHMA>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Abdij Bhat wrote:

>Hi,
> I am trying to build the 2.4.17 Kernel and upgrade my existing 2.4.7-10 Red
>Hat Linux System. Here is the procedure I followed ( based on Red Hat
>Documentation on the same ):
>
>1. tar -xvzf linux-2.4.17.tar.gz
>2. cd linux
>3. make mkproper
>4. make menuconfig
>5.make dep 
>6. make clean 
>7. make bzImage 
>8. make modules 
>9. make modules_install 
>10. cp /usr/src/linux-2.4.17/arch/i386/boot/bzImage /boot/vmlinuz-2.4.17 
>11. cp /usr/src/linux-2.4.17/System.map /boot/System.map-2.4.17 
>12. cd /boot rm System.map ln -s System.map-2.4.17 System.map 
>13. mkinitrd /boot/initrd-2.4.17.img 2.4.17 
>14. Modify the /etc/lilo.conf to add
>		image=/boot/vmlinuz-2.4.17
>		label=linux-Mine
>		root=/dev/hda1
>		initrd=/boot/initrd-2.4.17
>		read-only
>
> Now when i reboot and select the linux-Mine option the screen displays
>		Loading vmlinuz-2.4.7
>		Uncompressing Linux... Ok, booting the kernel
>
> and then HANGS!!!!!!
>
> What might be the problem. I have followed the instruction to the T. I
>tried without the initrd option too. I have enabled the RAM diak
>option/disabled it....
> 
> Please help me out on the issue.
>
>Thanks and Regards,
>Abdij
>
Have you tried checking what CPU type is configured on your kernel? it 
should be the same as your system's cpu.
Masoud


