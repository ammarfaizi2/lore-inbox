Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131691AbRDBMYK>; Mon, 2 Apr 2001 08:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131657AbRDBMXv>; Mon, 2 Apr 2001 08:23:51 -0400
Received: from [62.172.234.2] ([62.172.234.2]:11847 "EHLO penguin.homenet")
	by vger.kernel.org with ESMTP id <S131631AbRDBMXf>;
	Mon, 2 Apr 2001 08:23:35 -0400
Date: Mon, 2 Apr 2001 13:22:40 +0100 (BST)
From: Tigran Aivazian <tigran@veritas.com>
To: Wolfgang Rohdewald <WRohdewald@dplanet.ch>
cc: linux-ibcs2@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: 2.2.19 breaks iBCS2: Patch
In-Reply-To: <20010402095543.AEEF0400D2@poboxes.com>
Message-ID: <Pine.LNX.4.21.0104021321200.1612-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://sourceforge.net/projects/linux-abi/

iBCS has been ported and maintained against most of 2.3.x series for a
long time. And it is still, of course, available under 2.4.x, It is now
called ABI because old name iBCS was a misnomer (iBCS2 is an Intel
standard but the Linux implementation is far beyond the bounds of IA32
architecture -- it is portable, flexible and, in one word, perfect :)

Regards,
Tigran

On Mon, 2 Apr 2001, Wolfgang Rohdewald wrote:

> in 2.2.19, linux/include/asm-i386/uaccess.h is missing the line
> 
> #define strlen_user(str) strnlen_user(str, ~0UL >> 1)
> 
> putting it back makes iBCS2 work again.
> 
> Btw will iBCS2 ever be ported to the 2.4 kernel? I'm stuck with 2.2
> until this is ported.
> 
> Please CC: me, I'm not (yet) subscribed
> 
> Thanks, Wolfgang
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ibcs2" in
> the body of a message to majordomo@vger.kernel.org
> 

