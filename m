Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264284AbTEGULF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 16:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264289AbTEGULF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 16:11:05 -0400
Received: from smtp013.mail.yahoo.com ([216.136.173.57]:48905 "HELO
	smtp013.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264284AbTEGULC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 16:11:02 -0400
From: Michael Buesch <fsdeveloper@yahoo.de>
To: Nicolas Couture <nc@stormvault.net>
Subject: Re: Kernel Panic - IDE-SCSI
Date: Wed, 7 May 2003 22:23:15 +0200
User-Agent: KMail/1.5.1
References: <1052334839.3394.31.camel@gsiserver.gsitechusa.com>
In-Reply-To: <1052334839.3394.31.camel@gsiserver.gsitechusa.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200305072223.15436.fsdeveloper@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wednesday 07 May 2003 21:13, Nicolas Couture wrote:
> Hi,
>
> I found a bug in the scsi emulation support in the 2.4 serie.
>
> --- snip ---
> kung-foo:/home/user# echo foo > /proc/scsi/ide-scsi/0
> <1>Unable to handle kernel NULL pointer dereference at virtual address
> 00000000
>  printing eip:
> 00000000
> *pde = 00000000
> Oops: 0000
> CPU:    0
> EIP:    0010:[<00000000>]    Not tainted
> EFLAGS: 00010246
> eax: 00000000   ebx: c6b80000   ecx: 00000000   edx: c032c620
> esi: c11ffdb0   edi: 00000004   ebp: 00000004   esp: c70c1f5c
> ds: 0018   es: 0018   ss: 0018
> Process bash (pid: 5072, stackpage=c70c1000)
> Stack: c0207a4a c6b80000 c70c1f84 00000000 00000004 00000000 00000001
> 00000000
>        c47db120 ffffffea c010d09c c014c3df c47db120 40015000 00000004
> c11ffdb0
>        c0131715 c47db120 40015000 00000004 c47db140 c70c0000 00000004
> 40015000
> Call Trace:    [<c0207a4a>] [<c010d09c>] [<c014c3df>] [<c0131715>]
> [<c01086df>]
>
> Code:  Bad EIP value.
>  Segmentation fault
> user@kung-foo:~$
> --- snip ---
>
> Nicolas Couture

can you please run ksymoops on it?

- -- 
Regards Michael Büsch
http://www.8ung.at/tuxsoft
 22:22:48 up  7:39,  2 users,  load average: 1.01, 1.00, 1.00
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+uWszoxoigfggmSgRAuLZAJ9EjAXjwxDKIMEoaJrPRO3VnkgHuACeM/IY
QGS+mTf54H66EjERIWcC3d0=
=rZo3
-----END PGP SIGNATURE-----

