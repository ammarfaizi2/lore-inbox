Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291448AbSBAAUR>; Thu, 31 Jan 2002 19:20:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291449AbSBAAUH>; Thu, 31 Jan 2002 19:20:07 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:53778 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291448AbSBAAUB>; Thu, 31 Jan 2002 19:20:01 -0500
Subject: Re: [PATCH] Re: crc32 and lib.a (was Re: [PATCH] nbd in 2.5.3 does
To: davem@redhat.com (David S. Miller)
Date: Fri, 1 Feb 2002 00:32:11 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk, vandrove@vc.cvut.cz, torvalds@transmeta.com,
        garzik@havoc.gtf.org, linux-kernel@vger.kernel.org, paulus@samba.org,
        davidm@hpl.hp.com, ralf@gnu.org
In-Reply-To: <20020131.154547.74749379.davem@redhat.com> from "David S. Miller" at Jan 31, 2002 03:45:47 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16WRch-0003gh-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    Because 100 4K drivers suddenly becomes 0.5Mb.
> 
> However this isn't a driver, the crc library stuff is more akin to
> "strlen()".  Are you suggesting to provide a CONFIG_STRINGOPS=n
> too?  I wish you luck building that kernel :-)

For a large number of systems you don't need the CRC library. There are no
systems where you don't need memcpy, so your comparison is stupid to say
the least.

"Gee making this link is hard" is not a good reason to simplify the
config file, its a good reason to simplify the make file system
