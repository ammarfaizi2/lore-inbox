Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbTEBFzi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 01:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261804AbTEBFzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 01:55:38 -0400
Received: from 13.2-host.augustakom.net ([80.81.2.13]:2512 "EHLO phoebee")
	by vger.kernel.org with ESMTP id S261248AbTEBFzf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 01:55:35 -0400
Date: Fri, 2 May 2003 08:07:50 +0200
From: Martin Zwickel <martin.zwickel@technotrend.de>
To: "Frederic Trudeau" <ftrudeau@zesolution.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Fatal: Kernel /boot/vmlinux-2.4.18-27.7.xsmp is too big
Message-Id: <20030502080750.06debff3.martin.zwickel@technotrend.de>
In-Reply-To: <00b701c30f9e$772ec8b0$8000a8c0@ELBASTA>
References: <00b701c30f9e$772ec8b0$8000a8c0@ELBASTA>
Organization: TechnoTrend AG
X-Mailer: Sylpheed version 0.8.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Linux Phoebee 2.4.21-pre5-ac3 i686 Intel(R) Pentium(R) 4
 CPU 2.40GHz
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.q0j/)3uRRlKkqe"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.q0j/)3uRRlKkqe
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Frederic!

Shouldn't it be the compressed kernel image vmlinuz-2.4.18-27.7.xsmp?
                                                  ^ use z instead of x...

the difference is nearly 2Mb. With z it should work...

Regards,
Martin

On Thu, 1 May 2003 00:59:37 -0400
"Frederic Trudeau" <ftrudeau@zesolution.com> bubbled:

> Greetings.
> 
> I am really not sure if I post this problem to the right list, but here it
> is ...
> I've got RH 7.3 running on a i686 SMP machine. I downloaded and
> installed RedHat's kernel-smp-2.4.18-3 RPM, reconfigured lilo, rebooted,
> bingo.
> 
> Now im having problems with the kernel-smp-2.4.18-27.7.x RPM.
> 
> When trying to run lilo, I get the error message, that I pasted in the
> subject line
> Now, the error message is pretty obvious, but I still dont get why lilo (or
> anything
> else) wouls give me this error message, since this is a RPM that was build
> for
> my exact system architecture, and my exact OS.
> 
> Here is the content of my /boot directory :
> 
> -rw-r--r--    1 root     root          512 Apr 29 19:17 boot.0800
> -rw-r--r--    1 root     root         5824 Jun 24  2001 boot.b
> -rw-r--r--    1 root     root          612 Jun 24  2001 chain.b
> -rw-r--r--    1 root     root        42255 Mar 14 06:24
> config-2.4.18-27.7.xsmp
> -rw-r--r--    1 root     root        39947 Apr 18  2002 config-2.4.18-3
> -rw-r--r--    1 root     root        39945 Apr 18  2002 config-2.4.18-3smp
> drwxr-xr-x    2 root     root         1024 Apr 30 08:58 grub
> -rw-r--r--    1 root     root       267061 Apr 30 08:58
> initrd-2.4.18-27.7.xsmp.img
> -rw-r--r--    1 root     root       261683 Apr 29 19:08 initrd-2.4.18-3.img
> -rw-r--r--    1 root     root       268599 Apr 29 19:07
> initrd-2.4.18-3smp.img
> -rw-r--r--    1 root     root          477 Apr 29 19:22 kernel.h
> drwx------    2 root     root        12288 Apr 29 19:02 lost+found
> -rw-------    1 root     root        32768 Apr 29 20:11 map
> -rw-r--r--    1 root     root        23108 Jun 24  2001 message
> lrwxrwxrwx    1 root     root           20 Apr 29 19:08 module-info ->
> module-info-2.4.18-3
> -rw-r--r--    1 root     root        15436 Mar 14 06:24
> module-info-2.4.18-27.7.xsmp
> -rw-r--r--    1 root     root        14431 Apr 18  2002 module-info-2.4.18-3
> -rw-r--r--    1 root     root        14431 Apr 18  2002
> module-info-2.4.18-3smp
> -rw-r--r--    1 root     root          640 Jun 24  2001 os2_d.b
> lrwxrwxrwx    1 root     root           22 Apr 29 19:22 System.map ->
> System.map-2.4.18-3smp
> -rw-r--r--    1 root     root       518438 Mar 14 06:24
> System.map-2.4.18-27.7.xsmp
> -rw-r--r--    1 root     root       465966 Apr 18  2002 System.map-2.4.18-3
> -rw-r--r--    1 root     root       490685 Apr 18  2002
> System.map-2.4.18-3smp
> -rwxr-xr-x    1 root     root      3463389 Mar 14 06:24
> vmlinux-2.4.18-27.7.xsmp
> -rwxr-xr-x    1 root     root      2835238 Apr 18  2002 vmlinux-2.4.18-3
> -rwxr-xr-x    1 root     root      3176626 Apr 18  2002 vmlinux-2.4.18-3smp
> lrwxrwxrwx    1 root     root           16 Apr 29 19:08 vmlinuz ->
> vmlinuz-2.4.18-3
> -rw-r--r--    1 root     root      1155108 Mar 14 06:24
> vmlinuz-2.4.18-27.7.xsmp
> -rw-r--r--    1 root     root      1030147 Apr 18  2002 vmlinuz-2.4.18-3
> -rw-r--r--    1 root     root      1108097 Apr 18  2002 vmlinuz-2.4.18-3smp
> 
> Any pointers appreciated.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


-- 
Martin Zwickel <martin.zwickel@technotrend.de>

Research & Development

TechnoTrend AG <http://www.technotrend.de>
Werner-von-Siemens-Str. 6
86159 Augsburg (Germany)

Tel: [+49-821-450448-16] <---> Fax: [+49-821-450448-11]

--------------------------------------------------------------------
This email, together with any attachments,  is for the exclusive and
confidential use of the addressee(s). Any other distribution, use or
reproduction without the sender's prior consent is  unauthorised and
strictly  prohibited.  If  you have received this message  in error,
please notify the sender by email immediately and delete the message
from your computer without making copies.

--=.q0j/)3uRRlKkqe
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+sgs4mjLYGS7fcG0RApZxAJoDghrl5GwxicftPXsS+fH4YJUWtACgg5eq
MMg4aHZqix5Ppxh3Qd5AmM4=
=PYSe
-----END PGP SIGNATURE-----

--=.q0j/)3uRRlKkqe--
