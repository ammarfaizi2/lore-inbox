Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281992AbRKUXVl>; Wed, 21 Nov 2001 18:21:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281994AbRKUXVg>; Wed, 21 Nov 2001 18:21:36 -0500
Received: from c0mailgw.prontomail.com ([216.163.180.10]:12623 "EHLO
	c0mailgw03.prontomail.com") by vger.kernel.org with ESMTP
	id <S281992AbRKUXVV>; Wed, 21 Nov 2001 18:21:21 -0500
Message-ID: <3BFC36C5.7344981@starband.net>
Date: Wed, 21 Nov 2001 18:20:37 -0500
From: war <war@starband.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Miguel Maria Godinho de Matos <Astinus@netcabo.pt>
CC: linux-kernel@vger.kernel.org
Subject: Re: Ext3 not supported by kernel !!!!!
In-Reply-To: <EXCH01SMTP01eaCYPct00001063@smtp.netcabo.pt>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ext3 is supported in 2.4.15-pre2 and up.

Miguel Maria Godinho de Matos wrote:

> Hi again guys, i manage to compile the 2.4.14 kernel just fine, and did all
> the steps:
>
> make  menuconfig
> make dep
> ( didn't do make clean though )
> make modules
> make modules install
> cp arch/i386/boot/bzImage /boot/vzmiluz-2.4.14
> mkinitrd /boot/initrd-2.4.14.img
>
> edited my lilo and updated it ( /sbin/lilo )
>
> Then i rebooted and was expecting a happy ending though it not happened.
> after loading the kernel, when linux was suppose to mount the modules, the
> file system and so, an error appeard!!
>
> fs ext3 not supported by kernel
>
> kernel panic...... bla bla bla
>
> after that i reentered linux with my working kernel and did bzdisk just to
> check!
>
> then i rebooted and linux booted because the kernel needn't be mounted as it
> is in the floppy and initrf.immg as well.
>
> though when red hat came to mount the file system, instead of the beautifull
> [ ok ], a [ failed ] appeard, again with the error message:
>
> fs ext3 not supported by kernel!
>
> This was for what i  think something i misschoose in the make config step am
> i right??'
>
> If so can one of u tell me which menu contains the ext3 support for the
> kernel compilation.
>
> tks again, Astinus
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

