Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933278AbWLDFmU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933278AbWLDFmU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 00:42:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933351AbWLDFmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 00:42:20 -0500
Received: from py-out-1112.google.com ([64.233.166.176]:52055 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S933278AbWLDFmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 00:42:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:from:to:subject:date:mime-version:content-type:x-priority:x-msmail-priority:x-mailer:x-mimeole;
        b=NyHzssJcr+DTsAsxVd8fJB17nCEDV+kkunJnykJHKK95HwGTCz+SpQBDaN3dWoZwI/5xfwIrqdQ8KOagCCGNSa6JyZ4AAUWRQv8+OBrMMnuQGJpTqpBKe9Y8VSudyOHwzZNcBnRYtPNbIwfclKpc1nbFIfVZxd6XHzHJuNNBAqk=
Message-ID: <02ab01c71766$dcb2b1f0$270515ac@9BobZhang1>
From: "Bob Zhang" <zhanglinbao@gmail.com>
To: <linux-kernel@vger.kernel.org>
Subject: About watch dog timer limit of  CPU (Xscale ->IXP425) How can I set more long time ? 
Date: Mon, 4 Dec 2006 13:41:24 +0800
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_02A9_01C717A9.E3DEA680"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1807
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1807
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_02A9_01C717A9.E3DEA680
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: base64

SGVsbG8gYWxsICwgDQoNCiAgICBNeSBlbWJlZGVkIGJvYXJkIGhhcmR3YXJlIGNvbmZpZ3VyYXRp
b24gaXMgbGlrZSB0aGlzIDoNCiMgY2F0IC9wcm9jL2NwdWluZm8NClByb2Nlc3NvciAgICAgICA6
IFhTY2FsZS1JWFA0MjUvSVhDMTEwMCByZXYgMSAodjViKQ0KQm9nb01JUFMgICAgICAgIDogMjY2
LjI0DQpGZWF0dXJlcyAgICAgICAgOiBzd3AgaGFsZiB0aHVtYiBmYXN0bXVsdCBlZHNwIA0KDQpI
YXJkd2FyZSAgICAgICAgOiBJbnRlbCBJWERQNDI1IERldmVsb3BtZW50IFBsYXRmb3JtDQpSZXZp
c2lvbiAgICAgICAgOiAwMDAwDQpTZXJpYWwgICAgICAgICAgOiAwMDAwMDAwMDAwMDAwMDAwDQoN
ClRocm91Z2ggcmVhZGluZyBkYXRhc2hlZXQgb2YgaXhwNHh4ICxJIGtub3cgaXQgaGFzIG93biB3
YXRjaGRvZyBmdW5jdGlvbnMgLA0KcGxlYXNlIHNlZSBhdHRjaG1lbnQgOjE1IFRpbWVyIA0KDQpJ
IGZpbmQgYSBkcml2ZXIgYnkgZ29vbGUgLCANCnNlZSBhdHRhY2htZW50IC4NCg0KDQpXYXRjaGRv
ZyB0aW1lciBjb3VudGVyIGlzIDMyIGJpdCByZWdpc3RlciAsIGl0cyBtYXggdmFsdWUgaXMgMjw8
MzIgLTEgDQoNCiNkZWZpbmUgVElNRVJfRlJFUSA2NjAwMDAwMCAvKiA2NiBNSFogdGltZXIgKi8N
CiNkZWZpbmUgVElNRVJfS0VZIDB4NDgyZQ0KI2RlZmluZSBUSU1FUl9NQVJHSU4gNjAgIC8qIChz
ZWNzKSBEZWZhdWx0IGlzIDEgbWludXRlICovICAgICANCi8vSSB3YW50IHRvIG1vZGlmeSBpdCAs
SSBmaW5kIGl0cyBtYXggdmFsdWUgaXMgNjUNCg0Kc3RhdGljIGludCBpeHA0MjVfbWFyZ2luID0g
VElNRVJfTUFSR0lOOyAvKiBpbiBzZWNvbmRzICovDQpzdGF0aWMgaW50IGl4cDQyNXdkdF91c2Vy
czsNCi8vc3RhdGljIGludCBwcmVfbWFyZ2luOyAgLy9JWFA0MjUgQ1BVICdzIHdhdGNoIGRvZyB0
aW1lciBpcyAzMiBiaXQgLCANCi8vc28gSSBkZWZpbmUgaXQgdG8gYmUgdW5zaWduZWQgaW50IC0t
Ym9iDQpzdGF0aWMgdW5zaWduZWQgaW50IHByZV9tYXJnaW47ICAgDQpwcmVfbWFyZ2luID0gVElN
RVJfRlJFUSAqICBUSU1FUl9NQVJHSU4gDQoqSVhQNDI1X09TV1QgPSBwcmVfbWFyZ2luOyANCg0K
aWYgSSBuZWVkIG9uZSBtaW51dGVzICwgDQoqSVhQNDI1X09TV1QgPSA2NjAwMDAwMCAqIDYwID0g
IDM5NjAwMDAwMCAgLG5vdCBvdmVyZmxvdyAgDQoNCmlmIEkgbmVlZCB0d28gbWludXRlcyAsIA0K
KklYUDQyNV9PU1dUID0gNjYwMDAwMDAgKiAxMjAgPSA3OTIwMDAwMDAgICggd2hpY2ggaGFzIGJl
ZW4gPiAgMjw8MzItMSAgLCBvdmVyZmxvdyANCg0KU28gSSBjb21wdXRlIHRoZSBtYXggdGltZSBJ
IGNhbiBzZXQgOg0KIFRfbWF4ID0gMjw8MzItMSAvIDY2MDAwMDAwICAgID0gIDY1IHNlY29uZHMg
oaMgIA0KDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tDQpNeSBxdWVzdGlvbjoNCg0KaWYgbmVlZCBt
b3JlIHNlY29uZHMgKCBmb3IgZXhhbXBsZSAsIDUgbWludXRlcyApICx3aGF0IHNob3VsZCBJIGRv
ID8gDQoNCkkgaGF2ZSBhIG1ldGhvZCBiYXNlZCBvbiBkYXRhc2hlZXQgKGl4cDR4eCkgLGJ1dCBJ
IGRvbid0IGtub3cgaWYgaXQgd2lsbCBzdWNjZXNzZWQgd2hlbiBzeXN0ZW0gY3Jhc2ggDQoNCkhv
dyBjYW4gSSBkbyB0byBicmVhayB0aGUgbGltaXQgb2YgaGFyZHdhcmUgPyANClRoYW5rcyBhaGVh
ZCAhIA0KDQotLQ0KQmVzdCBSZWdhcmRzDQpib2I=

------=_NextPart_000_02A9_01C717A9.E3DEA680
Content-Type: application/octet-stream;
	name="ixp425_wdt.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="ixp425_wdt.c"

/*=0A=
 *	Watchdog driver for the IXP2400/IXP2800 based platforms=0A=
 *=0A=
 *      (c) Copyright 2000 Intel Coporation=0A=
 *          Based on SoftDog driver by Alan Cox <alan@redhat.com>=0A=
 *=0A=
 *	This program is free software; you can redistribute it and/or=0A=
 *	modify it under the terms of the GNU General Public License=0A=
 *	as published by the Free Software Foundation; either version=0A=
 *	2 of the License, or (at your option) any later version.=0A=
 *=0A=
 *	Neither Oleg Drokin nor iXcelerator.com admit liability nor provide=0A=
 *	warranty for any of this software. This material is provided=0A=
 *	"AS-IS" and at no charge.=0A=
 *=0A=
 *	Harold Yang <harold.yang@intel.com>=0A=
 *	Stanley Wang <stanley.wang@intel.com>=0A=
 *=0A=
 */=0A=
=0A=
#include <linux/module.h>=0A=
#include <linux/config.h>=0A=
#include <linux/types.h>=0A=
#include <linux/kernel.h>=0A=
#include <linux/fs.h>=0A=
#include <linux/mm.h>=0A=
#include <linux/miscdevice.h>=0A=
#include <linux/watchdog.h>=0A=
#include <linux/reboot.h>=0A=
#include <linux/smp_lock.h>=0A=
#include <linux/init.h>=0A=
#include <asm/uaccess.h>=0A=
#include <asm/hardware.h>=0A=
#include <asm/bitops.h>=0A=
#include <asm/arch/ixp425.h>=0A=
=0A=
#define MY_NAME "IXP425 Watchdog Timer"=0A=
=0A=
/* you must define it ,otherwise ,the timer will stop after write() =
,read()  */=0A=
//#define CONFIG_WATCHDOG_NOWAYOUT=0A=
=0A=
/* you can comment it ,if you don't debug */=0A=
#define CONFIG_IXP425_WTDEBUG=0A=
=0A=
#ifdef CONFIG_IXP425_WTDEBUG=0A=
#define dbg(format, arg...)                                     \=0A=
	do {                                                    \=0A=
		printk("<0>" "%s: " format,		\=0A=
				MY_NAME , ## arg);              \=0A=
        } while (0)=0A=
#else=0A=
#define dbg(format, arg...)=0A=
#endif=0A=
=0A=
#define TIMER_FREQ	66000000	/* 66 MHZ timer */=0A=
#define TIMER_KEY	0x482e=0A=
#define TIMER_MARGIN	66		/* (secs) Default is 1 minute */=0A=
=0A=
static int ixp425_margin =3D TIMER_MARGIN;	/* in seconds */=0A=
static int ixp425wdt_users;=0A=
//static int pre_margin;  //IXP425 CPU 's watch dog timer is 32 bit , so =
I define it to be unsigned int --bob=0A=
static unsigned int pre_margin;=0A=
=0A=
/*=0A=
 *	Allow only one person to hold it open=0A=
 */=0A=
=0A=
static int ixp425dog_open(struct inode *inode, struct file *file)=0A=
{=0A=
	if(test_and_set_bit(1,&ixp425wdt_users))=0A=
		return -EBUSY;=0A=
	MOD_INC_USE_COUNT;=0A=
	dbg("\n\nin open () function  , *IXP425_OSWT =3D %u\n",*IXP425_OSWT);=0A=
	dbg("ixp425_margin=3D%d\n",ixp425_margin);=0A=
	/* Activate IXP425 Watchdog timer */=0A=
	pre_margin=3DTIMER_FREQ * ixp425_margin;=0A=
	*IXP425_OSWK =3D TIMER_KEY; 	/* Unlock the watch dog timer */=0A=
	*IXP425_OSWT =3D pre_margin;	=0A=
	dbg("in open function pre_margin =3D %u\n",pre_margin);=0A=
	*IXP425_OSWE =3D 0x5;  //bit 0:reset ; bit 1:interupt; bit 2:counter =
down enable =0A=
	*IXP425_OSWK =3D 0;		/* Lock the watch dog timer */=0A=
	return 0;=0A=
}=0A=
=0A=
static int ixp425dog_release(struct inode *inode, struct file *file)=0A=
{=0A=
	/*=0A=
	 *	Shut off the timer.=0A=
	 * 	Lock it in if it's a module and we defined ...NOWAYOUT=0A=
	 */=0A=
	*IXP425_OSWK =3D TIMER_KEY; 	/* Unlock the watch dog timer */=0A=
	*IXP425_OSWT =3D pre_margin;=0A=
#ifndef CONFIG_WATCHDOG_NOWAYOUT=0A=
	*IXP425_OSWE =3D 0x0;=0A=
#endif=0A=
	*IXP425_OSWK =3D 0;		/* Lock the watch dog timer */=0A=
	ixp425wdt_users =3D 0;=0A=
	MOD_DEC_USE_COUNT;=0A=
	return 0;=0A=
}=0A=
=0A=
static ssize_t ixp425dog_write(struct file *file, const char *data, =
size_t len, loff_t *ppos)=0A=
{=0A=
	/*  Can't seek (pwrite) on this device  */=0A=
	if (ppos !=3D &file->f_pos)=0A=
		return -ESPIPE;=0A=
=0A=
	/* Refresh OSMR3 timer. */=0A=
	if(len) {=0A=
		dbg("has into write function len !=3D0  , *IXP425_OSWT =3D =
%u\n",*IXP425_OSWT);=0A=
		dbg("just IXP425_OSWT will set to be %u \n",pre_margin);=0A=
		*IXP425_OSWK =3D TIMER_KEY; 	/* Unlock the watch dog timer */=0A=
		*IXP425_OSWT =3D pre_margin;=0A=
		*IXP425_OSWK =3D 0;		/* Lock the watch dog timer */=0A=
		return 1;=0A=
	}=0A=
	return 0;=0A=
}=0A=
=0A=
/* it is only used to test the IXP425_OSWT register's value =0A=
  --BOB */=0A=
static ssize_t ixp425dog_read(struct file *file, char *data, size_t len, =
loff_t *ppos)=0A=
{=0A=
	=0A=
	/* read OSMR3 timer. */=0A=
	int current_timer =3D 0;=0A=
	char buffer[10] =3D {'\0'};=0A=
	=0A=
	dbg("has into read() function  , *IXP425_OSWT =3D %u\n",*IXP425_OSWT);=0A=
	//*IXP425_OSWK =3D TIMER_KEY; 	/* Unlock the watch dog timer */=0A=
	current_timer =3D *IXP425_OSWT ;=0A=
	//*IXP425_OSWK =3D 0;		/* Lock the watch dog timer */=0A=
	//-->=0A=
	snprintf(buffer,sizeof(buffer)-1,"%d",current_timer);=0A=
	copy_to_user(data,buffer,strlen(buffer));=0A=
	=0A=
}=0A=
=0A=
=0A=
=0A=
static int ixp425dog_ioctl(struct inode *inode, struct file *file,=0A=
	unsigned int cmd, unsigned long arg)=0A=
{=0A=
	int new_margin;=0A=
	int options =3D 0;=0A=
	static struct watchdog_info ident =3D {=0A=
		identity: "IXP425 Watchdog Timer",=0A=
		options: WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_CARDRESET,=0A=
	};=0A=
=0A=
	switch(cmd){=0A=
	default:=0A=
		return -ENOIOCTLCMD;=0A=
	case WDIOC_GETSUPPORT:=0A=
		return copy_to_user((struct watchdog_info *)arg, &ident, =
sizeof(ident));=0A=
	case WDIOC_GETSTATUS:=0A=
		return put_user(0,(int *)arg);=0A=
	case WDIOC_GETBOOTSTATUS:=0A=
		return put_user((*IXP425_OSST & 0x00000010) ? WDIOF_CARDRESET : 0, =
(int *)arg);=0A=
	case WDIOC_GETTEMP:=0A=
		return -ENOIOCTLCMD;=0A=
	case WDIOC_SETOPTIONS:=0A=
		if (get_user(options, (int *)arg))=0A=
			return -EFAULT;=0A=
		switch(options) {=0A=
			case WDIOS_DISABLECARD:=0A=
				*IXP425_OSWK =3D TIMER_KEY; 	/* Unlock the watch dog timer */=0A=
				*IXP425_OSWE =3D 0x0; =0A=
				*IXP425_OSWK =3D 0;		/* Lock the watch dog timer */=0A=
				return 0;=0A=
			case WDIOS_ENABLECARD:=0A=
				*IXP425_OSWK =3D TIMER_KEY; 	/* Unlock the watch dog timer */=0A=
				*IXP425_OSWE =3D 0x5; =0A=
				*IXP425_OSWK =3D 0;		/* Lock the watch dog timer */=0A=
				return 0;=0A=
			default:	=0A=
				return -ENOIOCTLCMD;		=0A=
		}=0A=
	case WDIOC_SETTIMEOUT:=0A=
		if (get_user(new_margin, (int *)arg))=0A=
			return -EFAULT;=0A=
		if (new_margin < 1)=0A=
			return -EINVAL;=0A=
		ixp425_margin =3D new_margin;=0A=
		pre_margin=3DTIMER_FREQ * ixp425_margin;=0A=
		*IXP425_OSWK =3D TIMER_KEY; 	/* Unlock the watch dog timer */=0A=
		*IXP425_OSWT =3D pre_margin;=0A=
		*IXP425_OSWK =3D 0;		/* Lock the watch dog timer */=0A=
		return 0;=0A=
	case WDIOC_GETTIMEOUT:=0A=
		put_user(ixp425_margin, (int *)arg);=0A=
		return 0;=0A=
	case WDIOC_KEEPALIVE:=0A=
		*IXP425_OSWK =3D TIMER_KEY; 	/* Unlock the watch dog timer */=0A=
		*IXP425_OSWT =3D pre_margin;=0A=
		*IXP425_OSWK =3D 0;		/* Lock the watch dog timer */=0A=
		return 0;=0A=
	}=0A=
}=0A=
=0A=
static struct file_operations ixp425dog_fops=3D=0A=
{=0A=
	owner:		THIS_MODULE,=0A=
	read:		ixp425dog_read,=0A=
	write:		ixp425dog_write,=0A=
	ioctl:		ixp425dog_ioctl,=0A=
	open:		ixp425dog_open,=0A=
	release:	ixp425dog_release,=0A=
};=0A=
=0A=
static struct miscdevice ixp425dog_miscdev=3D=0A=
{=0A=
	WATCHDOG_MINOR,=0A=
	"IXP425 watchdog",=0A=
	&ixp425dog_fops=0A=
};=0A=
=0A=
static int __init ixp425dog_init(void)=0A=
{=0A=
	int ret;=0A=
	dbg("WATCHDOG_MINOR =3D %d\n",WATCHDOG_MINOR);=0A=
	ret =3D misc_register(&ixp425dog_miscdev);=0A=
	dbg("ret of misc_register() =3D %d\n",ret);	=0A=
	if (ret)=0A=
		return ret;=0A=
=0A=
	dbg("timer margin %d sec\n", ixp425_margin);=0A=
=0A=
	return 0;=0A=
}=0A=
=0A=
static void __exit ixp425dog_exit(void)=0A=
{=0A=
	misc_deregister(&ixp425dog_miscdev);=0A=
}=0A=
=0A=
module_init(ixp425dog_init);=0A=
module_exit(ixp425dog_exit);=0A=
=0A=
MODULE_AUTHOR("Stanely Wang");=0A=
MODULE_LICENSE("GPL");=0A=
MODULE_PARM(ixp425_margin,"i");=0A=
MODULE_PARM_DESC(ixp425_margin,"IXP425 Watchdog Timer's expiring time.");=0A=
MODULE_DESCRIPTION("IXP425 Watchdog Timer driver.");=0A=
MODULE_SUPPORTED_DEVICE("IXCDP1100 dev board.");=0A=

------=_NextPart_000_02A9_01C717A9.E3DEA680--

