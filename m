Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277291AbRJJQHa>; Wed, 10 Oct 2001 12:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277294AbRJJQHU>; Wed, 10 Oct 2001 12:07:20 -0400
Received: from nsd.mandrakesoft.com ([216.71.84.35]:53547 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S277291AbRJJQHM>; Wed, 10 Oct 2001 12:07:12 -0400
Date: Wed, 10 Oct 2001 11:05:28 -0500 (CDT)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: Luis Montgomery <monty@fismat1.fcfm.buap.mx>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.11:compile 8139too as module fail
In-Reply-To: <Pine.GSO.4.21.0110100405540.27961-100000@fismat1.fcfm.buap.mx>
Message-ID: <Pine.LNX.3.96.1011010110448.24939A-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Oct 2001, Luis Montgomery wrote:
> This is the gcc report:
> 
> gcc -D__KERNEL__ -I/usr/src/linux-2.4.11/include -Wall -Wstrict-prototypes
> -Wno-
> trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe
> -mpref
> erred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS -include
> /usr/src/linu
> x-2.4.11/include/linux/modversions.h   -c -o 8139too.o 8139too.c
> 8139too.c: In function `netdev_ethtool_ioctl':
> 8139too.c:2419: Unrecognizable insn:
[...]
> 8139too.c:2419: Internal compiler error in reload_cse_simplify_operands,
> at reload1.c:8355

This is something to report to the gcc people not us...

	Jeff




