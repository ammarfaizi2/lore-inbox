Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291297AbSBQXXN>; Sun, 17 Feb 2002 18:23:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291305AbSBQXXD>; Sun, 17 Feb 2002 18:23:03 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10759 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291297AbSBQXWy>;
	Sun, 17 Feb 2002 18:22:54 -0500
Message-ID: <3C703B46.79890E96@mandrakesoft.com>
Date: Sun, 17 Feb 2002 18:22:46 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-2mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Francois Romieu <romieu@cogenit.fr>
CC: linux-kernel@vger.kernel.org, khc@pm.waw.pl, davem@redhat.com,
        torvalds@transmeta.com
Subject: Re: [PATCH] HDLC patch for 2.5.5 (0/3)
In-Reply-To: <20020217193005.B14629@se1.cogenit.fr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu wrote:
> [0/3]:
> - SIOCDEVICE -> SIOCWANDEV conversion
> - hdlc_proto -> raw_hdlc_proto

patch looks ok to me.

> diff -burpN linux-2.5.5-pre1-kh/include/linux/sockios.h linux-2.5.5-pre1-ma_pomme/include/linux/sockios.h
> --- linux-2.5.5-pre1-kh/include/linux/sockios.h Sun Feb 17 17:39:27 2002
> +++ linux-2.5.5-pre1-ma_pomme/include/linux/sockios.h   Sun Feb 17 16:39:23 > -#define SIOCDEVICE     0x894A          /* get/set netdev parameters    */
> +#define SIOCWANDEV     0x894A          /* get/set netdev parameters    */

a better comment might be nice...

-- 
Jeff Garzik      | "Why is it that attractive girls like you
Building 1024    |  always seem to have a boyfriend?"
MandrakeSoft     | "Because I'm a nympho that owns a brewery?"
                 |             - BBC TV show "Coupling"
