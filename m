Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312129AbSCQWUW>; Sun, 17 Mar 2002 17:20:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312130AbSCQWUM>; Sun, 17 Mar 2002 17:20:12 -0500
Received: from out019pub.verizon.net ([206.46.170.98]:43002 "EHLO
	out019.verizon.net") by vger.kernel.org with ESMTP
	id <S312129AbSCQWUA>; Sun, 17 Mar 2002 17:20:00 -0500
Date: Sun, 17 Mar 2002 17:19:59 -0500
From: Skip Ford <skip.ford@verizon.net>
To: Miles Lane <miles@megapathdsl.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.7-pre2 -- Error seeking in /dev/kmem
Mail-Followup-To: Miles Lane <miles@megapathdsl.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3C94F6FB.8090207@megapathdsl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C94F6FB.8090207@megapathdsl.net>; from miles@megapathdsl.net on Sun, Mar 17, 2002 at 12:05:15PM -0800
Message-Id: <20020317221959.JHCA26581.out019.verizon.net@pool-141-150-235-204.delv.east.verizon.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Miles Lane wrote:
> Is anyone else seeing this?  I have been getting these errors
> throughout much of the 2.5 development cycle.  I am not sure
> when the problem started, since I have had a lot of trouble
> getting most of the 2.5 series kernels to build.
> 
> Mar 17 11:15:02 turbulence kernel: Loaded 22474 symbols from 
> /boot/System.map-2.5.7-pre2.
> Mar 17 11:15:02 turbulence kernel: Symbols match kernel version 2.5.7.
> Mar 17 11:15:02 turbulence kernel: Error seeking in /dev/kmem
> Mar 17 11:15:02 turbulence kernel: Symbol #af_packet, value d98dd000
> Mar 17 11:15:02 turbulence kernel: Error adding kernel module table entry.

Mar 17 17:05:33 s kernel: Error seeking in /dev/kmem 
Mar 17 17:05:33 s kernel: Symbol #ipt_LOG, value d0894000 
Mar 17 17:05:33 s kernel: Error adding kernel module table entry. 

I've been wondering about those...they're always the first syslog
messages when I boot wth 2.5.7-pre1.

- -- 
Skip  ID: 0x7EDDDB0A
-----BEGIN PGP SIGNATURE-----

iEYEARECAAYFAjyVFnwACgkQBMKxVH7d2wo95wCdGuFC41ex/bD4GdoQiuTybWog
URgAn1nykM6H8TVnFWgBMvcn6yK9jXyy
=TJmO
-----END PGP SIGNATURE-----
