Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263122AbTKCVGm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 16:06:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263270AbTKCVGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 16:06:42 -0500
Received: from adsl-68-248-193-182.dsl.klmzmi.ameritech.net ([68.248.193.182]:35856
	"EHLO mail.domedata.com") by vger.kernel.org with ESMTP
	id S263122AbTKCVGj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 16:06:39 -0500
From: tabris <tabris@tabris.net>
To: Boylenate316@aol.com
Subject: Re: OOPS: Something about kswapd
Date: Mon, 3 Nov 2003 16:06:10 -0500
User-Agent: KMail/1.5.3
References: <59D81E86.2137402F.11E481F9@aol.com>
In-Reply-To: <59D81E86.2137402F.11E481F9@aol.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200311031606.11916.tabris@tabris.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

well, I can't say I know for sure, but there is a good chance you may have 
bad RAM. consider running memtest86 on it thru a couple passes.
I had a similar problem lately with kscand and kswapd

and it seems I had two single bit errors in one of my DIMMs

you can get memtest86 from http://www.memtest86.org

HTH

On Monday 03 November 2003 3:19 pm, Boylenate316@aol.com wrote:
> I'm not on the list.
> Kernel: 2.4.22, no patches
> CPU: AMD Athlon XP
> Memory: 512MB
> Swap: 1GB
> OOPS during ROCK linux compilation, I don't know which package...
> It didn't hang, but kswapd is defunct as I type.
> ksymoops output:
> ksymoops 2.3.7 on i686 2.4.22.  Options used
>      -v /usr/src/linux-2.4.22/vmlinux (specified)
>      -k /proc/ksyms (default)
>      -l /proc/modules (default)
>      -o /lib/modules/2.4.22/ (default)
>      -m /usr/src/linux-2.4.22/System.map (specified)
>
> Warning (compare_maps): mismatch on symbol tulip_max_interrupt_work  ,
> tulip says e0bf4a2c,
> /lib/modules/2.4.22/kernel/drivers/net/tulip/tulip.o says e0bf422c. 
> Ignoring /lib/modules/2.4.22/kernel/drivers/net/tulip/tulip.o entry
> Warning (compare_maps): mismatch on symbol tulip_rx_copybreak  , tulip
> says e0bf4a30, /lib/modules/2.4.22/kernel/drivers/net/tulip/tulip.o
> says e0bf4230.  Ignoring
> /lib/modules/2.4.22/kernel/drivers/net/tulip/tulip.o entry Warning
> (compare_maps): mismatch on symbol usb_devfs_handle  , usbcore says
> e0ba40d0, /lib/modules/2.4.22/kernel/drivers/usb/usbcore.o says
> e0ba3b50.  Ignoring /lib/modules/2.4.22/kernel/drivers/usb/usbcore.o
> entry unable to handle kernel NULL pointer dereference at virtual
> address 0000001c *pde = 00000000
> Oops: 0000
> CPU:    0
> EIP:    0010:[<c0138e64>]    Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010282
> eax: 00000000   ebx: c1435d5c   ecx: c1435d78   edx: cfa9a2c0
> esi: 000001d0   edi: 00002d82   ebp: c02d9eb0   esp: c1599f44
> ds: 0018   es: 0018   ss: 0018
> Process kswapd (pid: 4, stackpage=c1599000)
> Stack: 000001d0 c1435d5c c012f948 c1435d5c 000001d0 c1598000 00000200
> 000001d0
>        00000014 00000020 000001d0 00000020 00000006 c012fb30 00000006
> 0000000a
>        c02d9eb0 00000006 000001d0 c02d9eb0 00000000 c012fb90 00000020
> c02d9eb0
- --
tabris
- -
Predestination was doomed from the start.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/psNC1U5ZaPMbKQcRApNAAJwKaUcDSlSsfL1Ho3KWcgC5nMOiegCeNYjz
0fP9gW4+rf4Fdf1EPue6N98=
=ze2g
-----END PGP SIGNATURE-----

