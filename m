Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265139AbSLCDMr>; Mon, 2 Dec 2002 22:12:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265974AbSLCDMr>; Mon, 2 Dec 2002 22:12:47 -0500
Received: from sccrmhc02.attbi.com ([204.127.202.62]:3049 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S265139AbSLCDMo>; Mon, 2 Dec 2002 22:12:44 -0500
Subject: 2.5.50 -- arch/ppc/syslib/i8259.c:188: In function `i8259_init': 
	`SA_INTERRUPT' undeclared (first use in this function)
From: Miles Lane <miles.lane@attbi.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 02 Dec 2002 19:20:08 -0800
Message-Id: <1038885609.605.115.camel@jellybean>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  gcc -Wp,-MD,arch/ppc/syslib/.i8259.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-fomit-frame-pointer -I/usr/src/linux-2.5.50/arch/ppc -msoft-float -pipe
-ffixed-r2 -Wno-uninitialized -mmultiple -mstring -nostdinc -iwithprefix
include    -DKBUILD_BASENAME=i8259 -DKBUILD_MODNAME=i8259   -c -o
arch/ppc/syslib/i8259.o arch/ppc/syslib/i8259.c
arch/ppc/syslib/i8259.c: In function `i8259_init':
arch/ppc/syslib/i8259.c:188: `SA_INTERRUPT' undeclared (first use in
this function)
arch/ppc/syslib/i8259.c:188: (Each undeclared identifier is reported
only once
arch/ppc/syslib/i8259.c:188: for each function it appears in.)
make[1]: *** [arch/ppc/syslib/i8259.o] Error 1
make: *** [arch/ppc/syslib] Error 2


CONFIG_MMU=y
CONFIG_SWAP=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_HAVE_DEC_LOCK=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# General setup
#
CONFIG_NET=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y

#
# Loadable module support
#
# CONFIG_MODULES is not set

#
# Platform support
#
CONFIG_PPC=y
CONFIG_PPC32=y
CONFIG_6xx=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_ALL_PPC=y
CONFIG_PPC_STD_MMU=y
CONFIG_SERIAL_CONSOLE=y
CONFIG_ALL_PPC_CH=y
CONFIG_ALTIVEC=y
CONFIG_TAU=y
CONFIG_TAU_AVERAGE=y
CONFIG_PM=y

#
# General setup
#
CONFIG_HIGHMEM=y
CONFIG_PCI=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y
CONFIG_KERNEL_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_PCI_NAMES=y
CONFIG_HOTPLUG=y

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_EVDEV=y

#
# Input I/O drivers
#
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_SERIO_CT82C710=y

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y

#
# Macintosh device drivers
#
CONFIG_ADB_CUDA=y
CONFIG_ADB_PMU=y
CONFIG_PMAC_PBOOK=y
CONFIG_PMAC_APM_EMU=y
CONFIG_PMAC_BACKLIGHT=y
CONFIG_MAC_FLOPPY=y
CONFIG_MAC_SERIAL=y
CONFIG_ADB=y
CONFIG_ADB_MACIO=y
CONFIG_INPUT_ADBHID=y
CONFIG_MAC_EMUMOUSEBTN=y

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_CS=y
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_DETECT_IRQ=y

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=y

#
# I2C support
#
CONFIG_I2C=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCF=y
CONFIG_I2C_ELEKTOR=y
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_PROC=y

#
# PCMCIA character devices
#
CONFIG_SYNCLINK_CS=y
CONFIG_RAW_DRIVER=y

#
# Generic devices
#
CONFIG_SND_DUMMY=y
CONFIG_SND_VIRMIDI=y
CONFIG_SND_MTPAV=y
CONFIG_SND_SERIAL_U16550=y
CONFIG_SND_MPU401=y

#
# ALSA PowerMac devices
#
CONFIG_SND_POWERMAC=y

#
# USB Human Interface Devices (HID)
#
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y
CONFIG_USB_HIDDEV=y

#
# USB Serial Converter support
#
CONFIG_USB_SERIAL=y
CONFIG_USB_SERIAL_DEBUG=y
CONFIG_USB_SERIAL_CONSOLE=y
CONFIG_USB_SERIAL_GENERIC=y
CONFIG_USB_SERIAL_BELKIN=y
CONFIG_USB_SERIAL_WHITEHEAT=y
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=y
CONFIG_USB_SERIAL_EMPEG=y
CONFIG_USB_SERIAL_FTDI_SIO=y
CONFIG_USB_SERIAL_VISOR=y
CONFIG_USB_SERIAL_IPAQ=y
CONFIG_USB_SERIAL_IR=y
CONFIG_USB_SERIAL_EDGEPORT=y
CONFIG_USB_SERIAL_EDGEPORT_TI=y
CONFIG_USB_SERIAL_KEYSPAN_PDA=y
CONFIG_USB_SERIAL_KLSI=y
CONFIG_USB_SERIAL_MCT_U232=y
CONFIG_USB_SERIAL_PL2303=y
CONFIG_USB_SERIAL_SAFE=y
CONFIG_USB_SERIAL_SAFE_PADDED=y
CONFIG_USB_SERIAL_CYBERJACK=y
CONFIG_USB_SERIAL_XIRCOM=y
CONFIG_USB_SERIAL_OMNINET=y
CONFIG_USB_EZUSB=y


