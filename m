Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130607AbQKIUPV>; Thu, 9 Nov 2000 15:15:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131042AbQKIUPL>; Thu, 9 Nov 2000 15:15:11 -0500
Received: from scaup.prod.itd.earthlink.net ([207.217.121.49]:47808 "EHLO
	scaup.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S130867AbQKIUO4>; Thu, 9 Nov 2000 15:14:56 -0500
To: jamagallon@able.es
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
        Mandrake Kernel <kernel@linux-mandrake.com>
Subject: Re: Errors in 2.4-test11 build
In-Reply-To: <20001109023950.A4777@werewolf.able.es>
From: Chmouel Boudjnah <chmouel@mandrakesoft.com>
Date: 09 Nov 2000 12:13:36 -0800
In-Reply-To: <20001109023950.A4777@werewolf.able.es>
Message-ID: <m38zqszyxb.fsf@matrix.mandrakesoft.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J . A . Magallon" <jamagallon@able.es> writes:

> Trying to build 2.4.0-test11-pre1 I get the following:
> 
> make[1]: Entering directory `/usr/src/linux-2.4.0-test11/arch/i386/kernel'
> kgcc -D__ASSEMBLY__ -D__KERNEL__ -I/usr/src/linux/include -traditional -c
> trampoline.S -o trampoline.o
> gcc: installation problem, cannot exec `tradcpp0': No such file or directory
> make[1]: *** [trampoline.o] Error 1
> My egcs does not have a -traditional cpp (Mandrake 7.2, packages egcs and
> egcs-cpp).

sorry this is an error with the egcs package can you upgrade to these
packages :

ftp://ftp.chmouel.org/pub/people/chmou/kgcc/

and let me know if it's work for you (it does for me) and will do an
update soon.

-- 
MandrakeSoft Inc                     http://www.chmouel.org
                      --Chmouel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
