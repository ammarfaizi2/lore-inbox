Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319661AbSH3Te2>; Fri, 30 Aug 2002 15:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319662AbSH3Te2>; Fri, 30 Aug 2002 15:34:28 -0400
Received: from slkcdslgw12PoolC244.slkc.uswest.net ([65.100.254.244]:11375
	"EHLO shortcircuit.dyndns.org") by vger.kernel.org with ESMTP
	id <S319661AbSH3Te1>; Fri, 30 Aug 2002 15:34:27 -0400
Message-ID: <001701c2505c$e32ebea0$9600a8c0@yamatto>
From: "Dan Egli" <dan@shortcircuit.dyndns.org>
To: "Stefano Biella" <sbiella@hal9001.net>
Cc: <linux-kernel@vger.kernel.org>
References: <3D6FC85D.67286B32@hal9001.net>
Subject: Re: kernel panic: no init found with 2.5.32
Date: Fri, 30 Aug 2002 13:38:57 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What are you passing as the init= arg? What is your boot manager? (Grub?
Lilo? 3rd Party?)

no init means that when the kernel boot sequence tries to spawn off
/sbin/init, it cannot find the file.The fault could be any one of multiple.
It would help in the future if for problems like this you pasted your boot
loader config file.
----- Original Message -----
From: "Stefano Biella" <sbiella@hal9001.net>
To: <linux-kernel@vger.kernel.org>
Sent: Friday, August 30, 2002 1:32 PM
Subject: kernel panic: no init found with 2.5.32


> I have a slackware 8.1 machine that works fine with 2.4.18/19 kernels,
> but,when I reboot with the 2.5.31/32 kernels, the system have a "kernel
> panic: no init found. try passing init= option to kernel" The fs is a
> reisersfs v.3.6 on Intel PIIX4 chipset with udma33 disk.
> The disk is not corrupted because if I back to 2.4.X the machine boot
> fine.
>
> what's wrong?
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

