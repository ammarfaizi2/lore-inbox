Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279064AbRKOA6n>; Wed, 14 Nov 2001 19:58:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279103AbRKOA6d>; Wed, 14 Nov 2001 19:58:33 -0500
Received: from [193.252.19.44] ([193.252.19.44]:38133 "EHLO
	mel-rti19.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S279064AbRKOA6X> convert rfc822-to-8bit; Wed, 14 Nov 2001 19:58:23 -0500
Message-ID: <3BF365A1.3050008@free.fr>
Date: Thu, 15 Nov 2001 01:50:09 -0500
From: FORT David <popo.enlighted@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5+) Gecko/20011114
X-Accept-Language: fr, en-us
MIME-Version: 1.0
To: tommasi@univ-lille3.fr
CC: linux-kernel@vger.kernel.org
Subject: Re: mount /mnt/cdrom = segfault
In-Reply-To: <3BF2E136.396C35BE@free.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tommasi Marc wrote:

>Hello, 
>  I cannot explain why the mount command issues with a segmentation 
>fault. 
>  Kernel messages indicates 
>
>Nov 14 20:44:38 marion kernel: devfs: devfs_register(): device already
>registered: "cd"
>Nov 14 20:44:38 marion kernel: hdc: ide_cdrom_setup failed to register
>device with the cdrom driver.
>Nov 14 20:44:38 marion kernel: Unable to handle kernel NULL pointer
>dereference at virtual address 00000028
>Nov 14 20:44:38 marion kernel:  printing eip:
>Nov 14 20:44:38 marion kernel: c018ba8f
>Nov 14 20:44:38 marion kernel: *pde = 00000000
>Nov 14 20:44:38 marion kernel: Oops: 0000
>Nov 14 20:44:38 marion kernel: CPU:    0
>Nov 14 20:44:38 marion kernel: EIP:   
>0010:[ide_revalidate_disk+223/272]
>Nov 14 20:44:38 marion kernel: EIP:    0010:[<c018ba8f>]
>Nov 14 20:44:38 marion kernel: EFLAGS: 00010212
>Nov 14 20:44:38 marion kernel: eax: 00000000   ebx: 00001600   ecx:
>00001600   edx: 00000000
>Nov 14 20:44:38 marion kernel: esi: c03591d0   edi: 00001100   ebp:
>00000040   esp: c813dec8
>Nov 14 20:44:38 marion kernel: ds: 0018   es: 0018   ss: 0018
>Nov 14 20:44:38 marion kernel: Process mount (pid: 2502,
>stackpage=c813d000)
>Nov 14 20:44:38 marion kernel: Stack: 16000330 00000000 00000330
>00000000 c0359498 00000330 c018bb0a 00001600
>Nov 14 20:44:38 marion kernel:        00000001 c03591d0 ce8cfc60
>00000000 ce8cfc60 c018bbd4 c149a5a0 ce8cfc60
>Nov 14 20:44:38 marion kernel:        c0138a38 ce8cfc60 c82447a0
>c14c3240 00000000 c14c3244 c015d7df ce8cfc60
>Nov 14 20:44:38 marion kernel: Call Trace: [revalidate_drives+74/128]
>[ide_open+52/240] [blkdev_open+72/128] [devfs_open+191/416]
>[dentry_open+192/336]
>Nov 14 20:44:38 marion kernel: Call Trace: [<c018bb0a>] [<c018bbd4>]
>[<c0138a38>] [<c015d7df>] [<c0131d60>]
>Nov 14 20:44:38 marion kernel:    [filp_open+75/96] [getname+95/160]
>[sys_open+54/176] [system_call+51/64]
>Nov 14 20:44:38 marion kernel:    [<c0131c8b>] [<c013b45f>] [<c0131f76>]
>[<c0106ec3>]
>Nov 14 20:44:38 marion kernel:
>Nov 14 20:44:38 marion kernel: Code: 8b 40 28 85 c0 74 04 56 ff d0 5b 80
>a6 ae 00 00 00 fb 8d 86
>
>
>
>I have tried no boot with devfs=nomount but I have still the same kind
>of message. 
>I whish to be cc'ed the answers.
>Thanks a lot.
>
>Marc.
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
Kernel version and box features could help....
Please read the Howto Oops in the kernel documentation, and resubmit
the Oops.

-- 
%-------------------------------------------------------------------------%
% FORT David,                                                  0668373331 %
% 5 boulevard de solférino                                     0299679330 %
% 35000 Rennes, France                             popo.enlighted@free.fr %
% ICU:78064991 								  %
%--LINUX-HTTPD-PIOGENE----------------------------------------------------%
%  -datamining <-/                        |   .~.                         %
%  -networking/PHP/java/JSPs              |   /V\        L  I  N  U  X    %
%  -opensource                            |  // \\     >Fear the Penguin< %
%  -GNOME/enlightenment/GIMP              | /(   )\                       %
%           feel enlightened....          |  ^^-^^                        %
%                              HomePage: http://www.enlightened-popo.net  %
%---------- -- This was sent by Djinn running Linux 2.4.13 -- ------------%



