Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261308AbTEDSDr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 14:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbTEDSDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 14:03:47 -0400
Received: from smtp011.mail.yahoo.com ([216.136.173.31]:21765 "HELO
	smtp011.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261308AbTEDSDq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 14:03:46 -0400
From: Michael Buesch <fsdeveloper@yahoo.de>
To: Felix von Leitner <felix-kernel@fefe.de>
Subject: Re: [2.5.68] Scalability issues
Date: Sun, 4 May 2003 20:16:03 +0200
User-Agent: KMail/1.5.1
References: <20030504173956.GA28370@codeblau.de>
In-Reply-To: <20030504173956.GA28370@codeblau.de>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200305042016.13982.fsdeveloper@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sunday 04 May 2003 19:39, Felix von Leitner wrote:
>   Unable to handle kernel NULL pointer dereference at virtual address
> 00000017 printing eip:
>   c014c95b
>   *pde = 00000000
>   Oops: 0000 [#1]
>   CPU:    0
>   EIP:    0060:[<c014c95b>]    Tainted: P
>   EFLAGS: 00010286
>   eax: d241b000   ebx: 00000003   ecx: c037c450   edx: 00000003
>   esi: 00000405   edi: c3194620   ebp: 00000021   esp: c379bf60
>   ds: 007b   es: 007b   ss: 0068
>   Process artillery-fork (pid: 6966, threadinfo=c379a000 task=c37bad80)
>   Stack: c0341e60 c3194620 07ffffff 00000405 c3194620 00000021 c011e21c
> 00000003 c3194620 c3194620 00000000 4003c904 c37bad80 c011edc4 c319d780
> c319d780 c379a000 c014d557 00000000 00200001 4003c904 c379a000 c011f0b3
> 00000000 Call Trace: [<c011e21c>]  [<c011edc4>]  [<c014d557>]  [<c011f0b3>]
>  [<c0109279>] Code: 8b 43 14 85 c0 0f 84 9a 00 00 00 8b 43 10 31 ed 85 c0
> 74 45

Could you please run ksymoops on these oopses?

>   EIP:    0060:[<c014c95b>]    Tainted: P
What tainted the kernel?

- -- 
Regards Michael Büsch
http://www.8ung.at/tuxsoft
 20:14:28 up  3:44,  4 users,  load average: 1.01, 1.05, 1.01
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+tVjtoxoigfggmSgRAlPeAJ4im7EzpQjk2ZRHk3TS1rECLFcB3wCeNhUy
A3yhshZJpMURwsLgX7hVzrY=
=5IoZ
-----END PGP SIGNATURE-----

