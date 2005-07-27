Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262019AbVG0Gwp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262019AbVG0Gwp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 02:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262020AbVG0Gwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 02:52:45 -0400
Received: from mail132.messagelabs.com ([216.82.241.3]:5484 "HELO
	mail122.messagelabs.com") by vger.kernel.org with SMTP
	id S262019AbVG0Gwo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 02:52:44 -0400
X-VirusChecked: Checked
X-Env-Sender: vikas.g@ap.sony.com
X-Msg-Ref: server-9.tower-132.messagelabs.com!1122447160!12314869!1
X-StarScan-Version: 5.4.15; banners=-,-,-
X-Originating-IP: [202.42.154.67]
From: "Vikas" <vikas.g@ap.sony.com>
To: "Michael Berger" <mikeb1@t-online.de>, <linux-kernel@vger.kernel.org>
Subject: Why this is not working ....
Date: Wed, 27 Jul 2005 12:21:47 +0530
Message-ID: <GOEALLDEHIHLBCJFMCOOAEMBCBAA.vikas.g@ap.sony.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 1 (Highest)
X-MSMail-Priority: High
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: High
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
In-Reply-To: <42E72E5F.8080606@t-online.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PATH=' \ /home\ / $2 \ / $3 \ / lib '
Why $2 and $3 are not replaced by user passed argument


-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Michael Berger
Sent: Wednesday, July 27, 2005 12:19 PM
To: linux-kernel@vger.kernel.org
Subject: Build error in Kernel 2.6.13-rc3 git current

Dear Kernel Hackers

I would like to report following build error in Kernel 2.6.13-rc3 git
current:

   gcc -m32 -Wp,-MD,init/.do_mounts_initrd.o.d  -nostdinc -isystem
/usr/lib/gcc-lib/i486-linux/3.3.5/include -D__KERNEL__ -Iinclude  -Wall
-Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common
-ffreestanding -O2     -fomit-frame-pointer -pipe -msoft-float
-mpreferred-stack-boundary=2  -march=i686  -mregparm=3
-Iinclude/asm-i386/mach-default      -DKBUILD_BASENAME=do_mounts_initrd
-DKBUILD_MODNAME=mounts -c -o init/do_mounts_initrd.o
init/do_mounts_initrd.c
In file included from include/asm/unistd.h:426,
                  from include/linux/unistd.h:9,
                  from init/do_mounts_initrd.c:2:
include/asm/ptrace.h: In function `user_mode_vm':
include/asm/ptrace.h:67: error: `VM_MASK' undeclared (first use in this
function)
include/asm/ptrace.h:67: error: (Each undeclared identifier is reported
only once
include/asm/ptrace.h:67: error: for each function it appears in.)
make[1]: *** [init/do_mounts_initrd.o] Error 1
make: *** [init] Error 2

Attached you will find my config file which triggers this build error.

Best regards,


-- Michael Berger


