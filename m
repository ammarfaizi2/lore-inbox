Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbUBZV23 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 16:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261220AbUBZV23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 16:28:29 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:28132 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261369AbUBZV2K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 16:28:10 -0500
Date: Thu, 26 Feb 2004 22:27:59 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, netdev@oss.sgi.com
Cc: linux-kernel@vger.kernel.org
Subject: 2.4.26-pre1: SCTP compile error
Message-ID: <20040226212759.GV5499@fs.tum.de>
References: <Pine.LNX.4.58L.0402251605360.5003@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58L.0402251605360.5003@logos.cnet>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 25, 2004 at 04:09:20PM -0300, Marcelo Tosatti wrote:
>...
> It contains a big SCTP merge (to match 2.6 API), networking updates,
>...

I got the compile error forwarded below using gcc 2.95.3 .

cu
Adrian



...
gcc-2.95 -D__KERNEL__ -I/home/bunk/linux/kernel-2.4/linux-2.4.26-pre1-full/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4   -nostdinc -iwithprefix include -DKBUILD_BASENAME=ipv6  -c -o ipv6.o ipv6.c
In file included from ipv6.c:77:
/home/bunk/linux/kernel-2.4/linux-2.4.26-pre1-full/include/net/sctp/sctp.h:119: warning: `MSECS_TO_JIFFIES' redefined
/home/bunk/linux/kernel-2.4/linux-2.4.26-pre1-full/include/net/irda/irda.h:89: warning: this is the location of the previous definition
ipv6.c: In function `sctp_v6_xmit':
ipv6.c:189: request for member `in6_u' in something not a structure or union
ipv6.c:189: request for member `in6_u' in something not a structure or union
ipv6.c:189: request for member `in6_u' in something not a structure or union
ipv6.c:189: request for member `in6_u' in something not a structure or union
ipv6.c:189: request for member `in6_u' in something not a structure or union
ipv6.c:189: request for member `in6_u' in something not a structure or union
ipv6.c:189: request for member `in6_u' in something not a structure or union
ipv6.c:189: request for member `in6_u' in something not a structure or union
ipv6.c:189: request for member `in6_u' in something not a structure or union
ipv6.c:189: request for member `in6_u' in something not a structure or union
ipv6.c:189: request for member `in6_u' in something not a structure or union
ipv6.c:189: request for member `in6_u' in something not a structure or union
ipv6.c:189: request for member `in6_u' in something not a structure or union
ipv6.c:189: request for member `in6_u' in something not a structure or union
ipv6.c:189: request for member `in6_u' in something not a structure or union
ipv6.c:189: request for member `in6_u' in something not a structure or union
ipv6.c:189: request for member `in6_u' in something not a structure or union
ipv6.c:189: request for member `in6_u' in something not a structure or union
ipv6.c:189: request for member `in6_u' in something not a structure or union
ipv6.c:189: request for member `in6_u' in something not a structure or union
ipv6.c:189: request for member `in6_u' in something not a structure or union
ipv6.c:189: request for member `in6_u' in something not a structure or union
ipv6.c:189: request for member `in6_u' in something not a structure or union
ipv6.c:189: request for member `in6_u' in something not a structure or union
ipv6.c:189: request for member `in6_u' in something not a structure or union
ipv6.c:189: request for member `in6_u' in something not a structure or union
ipv6.c:189: request for member `in6_u' in something not a structure or union
ipv6.c:189: request for member `in6_u' in something not a structure or union
ipv6.c:189: request for member `in6_u' in something not a structure or union
ipv6.c:189: request for member `in6_u' in something not a structure or union
ipv6.c:189: request for member `in6_u' in something not a structure or union
ipv6.c:189: request for member `in6_u' in something not a structure or union
ipv6.c:189: request for member `in6_u' in something not a structure or union
ipv6.c:189: request for member `in6_u' in something not a structure or union
ipv6.c:189: request for member `in6_u' in something not a structure or union
ipv6.c:189: request for member `in6_u' in something not a structure or union
ipv6.c:189: request for member `in6_u' in something not a structure or union
ipv6.c:189: request for member `in6_u' in something not a structure or union
ipv6.c:189: request for member `in6_u' in something not a structure or union
ipv6.c:189: request for member `in6_u' in something not a structure or union
ipv6.c:189: request for member `in6_u' in something not a structure or union
ipv6.c:189: request for member `in6_u' in something not a structure or union
ipv6.c:189: request for member `in6_u' in something not a structure or union
ipv6.c:189: request for member `in6_u' in something not a structure or union
ipv6.c:189: request for member `in6_u' in something not a structure or union
ipv6.c:189: request for member `in6_u' in something not a structure or union
ipv6.c:189: request for member `in6_u' in something not a structure or union
ipv6.c:189: request for member `in6_u' in something not a structure or union
ipv6.c: In function `sctp_v6_get_dst':
ipv6.c:213: request for member `in6_u' in something not a structure or union
ipv6.c:213: request for member `in6_u' in something not a structure or union
ipv6.c:213: request for member `in6_u' in something not a structure or union
ipv6.c:213: request for member `in6_u' in something not a structure or union
ipv6.c:213: request for member `in6_u' in something not a structure or union
ipv6.c:213: request for member `in6_u' in something not a structure or union
ipv6.c:213: request for member `in6_u' in something not a structure or union
ipv6.c:213: request for member `in6_u' in something not a structure or union
ipv6.c:213: request for member `in6_u' in something not a structure or union
ipv6.c:213: request for member `in6_u' in something not a structure or union
ipv6.c:213: request for member `in6_u' in something not a structure or union
ipv6.c:213: request for member `in6_u' in something not a structure or union
ipv6.c:213: request for member `in6_u' in something not a structure or union
ipv6.c:213: request for member `in6_u' in something not a structure or union
ipv6.c:213: request for member `in6_u' in something not a structure or union
ipv6.c:213: request for member `in6_u' in something not a structure or union
ipv6.c:213: request for member `in6_u' in something not a structure or union
ipv6.c:213: request for member `in6_u' in something not a structure or union
ipv6.c:213: request for member `in6_u' in something not a structure or union
ipv6.c:213: request for member `in6_u' in something not a structure or union
ipv6.c:213: request for member `in6_u' in something not a structure or union
ipv6.c:213: request for member `in6_u' in something not a structure or union
ipv6.c:213: request for member `in6_u' in something not a structure or union
ipv6.c:213: request for member `in6_u' in something not a structure or union
ipv6.c:219: request for member `in6_u' in something not a structure or union
ipv6.c:219: request for member `in6_u' in something not a structure or union
ipv6.c:219: request for member `in6_u' in something not a structure or union
ipv6.c:219: request for member `in6_u' in something not a structure or union
ipv6.c:219: request for member `in6_u' in something not a structure or union
ipv6.c:219: request for member `in6_u' in something not a structure or union
ipv6.c:219: request for member `in6_u' in something not a structure or union
ipv6.c:219: request for member `in6_u' in something not a structure or union
ipv6.c:219: request for member `in6_u' in something not a structure or union
ipv6.c:219: request for member `in6_u' in something not a structure or union
ipv6.c:219: request for member `in6_u' in something not a structure or union
ipv6.c:219: request for member `in6_u' in something not a structure or union
ipv6.c:219: request for member `in6_u' in something not a structure or union
ipv6.c:219: request for member `in6_u' in something not a structure or union
ipv6.c:219: request for member `in6_u' in something not a structure or union
ipv6.c:219: request for member `in6_u' in something not a structure or union
ipv6.c:219: request for member `in6_u' in something not a structure or union
ipv6.c:219: request for member `in6_u' in something not a structure or union
ipv6.c:219: request for member `in6_u' in something not a structure or union
ipv6.c:219: request for member `in6_u' in something not a structure or union
ipv6.c:219: request for member `in6_u' in something not a structure or union
ipv6.c:219: request for member `in6_u' in something not a structure or union
ipv6.c:219: request for member `in6_u' in something not a structure or union
ipv6.c:219: request for member `in6_u' in something not a structure or union
make[3]: *** [ipv6.o] Error 1
make[3]: Leaving directory `/home/bunk/linux/kernel-2.4/linux-2.4.26-pre1-full/net/sctp'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/home/bunk/linux/kernel-2.4/linux-2.4.26-pre1-full/net/sctp'
make[1]: *** [_subdir_sctp] Error 2
make[1]: Leaving directory `/home/bunk/linux/kernel-2.4/linux-2.4.26-pre1-full/net'
make: *** [_dir_net] Error 2
