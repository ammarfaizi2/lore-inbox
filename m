Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281771AbRKUXHJ>; Wed, 21 Nov 2001 18:07:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281968AbRKUXHA>; Wed, 21 Nov 2001 18:07:00 -0500
Received: from a212-113-174-249.netcabo.pt ([212.113.174.249]:26661 "EHLO
	smtp.netcabo.pt") by vger.kernel.org with ESMTP id <S281771AbRKUXGm>;
	Wed, 21 Nov 2001 18:06:42 -0500
Content-Type: text/plain; charset=US-ASCII
From: Miguel Maria Godinho de Matos <Astinus@netcabo.pt>
To: linux-kernel@vger.kernel.org
Subject: Ext3 not supported by kernel !!!!!
Date: Wed, 21 Nov 2001 23:07:31 +0000
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <EXCH01SMTP01eaCYPct00001063@smtp.netcabo.pt>
X-OriginalArrivalTime: 21 Nov 2001 23:06:14.0072 (UTC) FILETIME=[1E10F380:01C172E1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again guys, i manage to compile the 2.4.14 kernel just fine, and did all 
the steps:

make  menuconfig
make dep
( didn't do make clean though )
make modules
make modules install
cp arch/i386/boot/bzImage /boot/vzmiluz-2.4.14
mkinitrd /boot/initrd-2.4.14.img

edited my lilo and updated it ( /sbin/lilo )

Then i rebooted and was expecting a happy ending though it not happened.
after loading the kernel, when linux was suppose to mount the modules, the 
file system and so, an error appeard!!

fs ext3 not supported by kernel

kernel panic...... bla bla bla

after that i reentered linux with my working kernel and did bzdisk just to 
check!

then i rebooted and linux booted because the kernel needn't be mounted as it 
is in the floppy and initrf.immg as well.

though when red hat came to mount the file system, instead of the beautifull 
[ ok ], a [ failed ] appeard, again with the error message:

fs ext3 not supported by kernel!

This was for what i  think something i misschoose in the make config step am 
i right??'

If so can one of u tell me which menu contains the ext3 support for the 
kernel compilation.

tks again, Astinus
