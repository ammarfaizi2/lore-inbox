Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132883AbRDXINV>; Tue, 24 Apr 2001 04:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132890AbRDXINL>; Tue, 24 Apr 2001 04:13:11 -0400
Received: from [193.220.116.69] ([193.220.116.69]:21003 "HELO mail.ipko.org")
	by vger.kernel.org with SMTP id <S132883AbRDXING>;
	Tue, 24 Apr 2001 04:13:06 -0400
Content-Type: text/plain; charset=US-ASCII
From: Astrit Zhushi <astrit@ipko.org>
To: linux-kernel@vger.kernel.org
Subject: I think is a bug
Date: Tue, 24 Apr 2001 00:46:48 +0200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01042400464800.01997@astrit.ipko.net>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.. there

first of all I would like to say sorry if this e-mail was not send to right 
place, but I just wanted to inform I don't know if it is a bug, I'm kompiling 
kernel2.4.3 and I've included IPX protocol but the kernel will not compile, 
bellow is a message that I get when compilling the kernel with IPX:


-----------------------------------------------------------
rm -f math.o
ld -m elf_i386  -r -o math.o fpu_entry.o errors.o fpu_arith.o fpu_aux.o 
fpu_etc.o fpu_tags.o fpu_trig.o load_store.o get_address.o poly_atan.o 
poly_l2.o poly_2xm1.o poly_sin.o poly_tan.o reg_add_sub.o reg_compare.o 
reg_constant.o reg_convert.o reg_ld_str.o reg_divide.o reg_mul.o reg_u_add.o 
reg_u_div.o reg_u_mul.o reg_u_sub.o div_small.o reg_norm.o reg_round.o 
wm_shrx.o wm_sqrt.o div_Xsig.o polynom_Xsig.o round_Xsig.o shr_Xsig.o 
mul_Xsig.o
make[2]: Leaving directory 
`/usr/home/Software/Kernel2.4.3/linux/arch/i386/math-emu'
make[1]: Leaving directory 
`/usr/home/Software/Kernel2.4.3/linux/arch/i386/math-emu'
ld -m elf_i386 -T /usr/home/Software/Kernel2.4.3/linux/arch/i386/vmlinux.lds 
-e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o 
init/version.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o 
fs/fs.o ipc/ipc.o \
        drivers/block/block.o drivers/char/char.o drivers/misc/misc.o 
drivers/net/net.o drivers/media/media.o  drivers/parport/driver.o 
drivers/char/agp/agp.o drivers/char/drm/drm.o drivers/ide/idedriver.o 
drivers/cdrom/driver.o drivers/sound/sounddrivers.o drivers/pci/driver.o 
drivers/pnp/pnp.o drivers/video/video.o drivers/usb/usbdrv.o 
drivers/acpi/acpi.o arch/i386/math-emu/math.o \
        net/network.o \
        /usr/home/Software/Kernel2.4.3/linux/arch/i386/lib/lib.a 
/usr/home/Software/Kernel2.4.3/linux/lib/lib.a 
/usr/home/Software/Kernel2.4.3/linux/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
net/network.o(.data+0x3164): undefined reference to 
`sysctl_ipx_pprop_broadcasting'
make: *** [vmlinux] Error 1
--------------------------------------------------------------

when I remove the IPX the kernel compiles fine without any problems....

I thought this might be of you intereset, 

Best Regards

Astrit Zhushi
astrit@ipko.org

