Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129148AbQKIX5p>; Thu, 9 Nov 2000 18:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129486AbQKIX5f>; Thu, 9 Nov 2000 18:57:35 -0500
Received: from jalon.able.es ([212.97.163.2]:21221 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129148AbQKIX5Q>;
	Thu, 9 Nov 2000 18:57:16 -0500
Date: Fri, 10 Nov 2000 00:57:04 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Chmouel Boudjnah <chmouel@mandrakesoft.com>
Cc: jamagallon@able.es, Linux Kernel List <linux-kernel@vger.kernel.org>,
        Mandrake Kernel <kernel@linux-mandrake.com>
Subject: Re: Errors in 2.4-test11 build
Message-ID: <20001110005704.G747@werewolf.able.es>
Reply-To: jamagallon@able.es
In-Reply-To: <20001109023950.A4777@werewolf.able.es> <m38zqszyxb.fsf@matrix.mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <m38zqszyxb.fsf@matrix.mandrakesoft.com>; from chmouel@mandrakesoft.com on Thu, Nov 09, 2000 at 21:13:36 +0100
X-Mailer: Balsa 1.0.pre2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 09 Nov 2000 21:13:36 Chmouel Boudjnah wrote:
> "J . A . Magallon" <jamagallon@able.es> writes:
> 
> > Trying to build 2.4.0-test11-pre1 I get the following:
> > 
> > make[1]: Entering directory `/usr/src/linux-2.4.0-test11/arch/i386/kernel'
> > kgcc -D__ASSEMBLY__ -D__KERNEL__ -I/usr/src/linux/include -traditional -c
> > trampoline.S -o trampoline.o
> > gcc: installation problem, cannot exec `tradcpp0': No such file or directory
> > make[1]: *** [trampoline.o] Error 1
> > My egcs does not have a -traditional cpp (Mandrake 7.2, packages egcs and
> > egcs-cpp).
> 
> sorry this is an error with the egcs package can you upgrade to these
> packages :
> 
> ftp://ftp.chmouel.org/pub/people/chmou/kgcc/
> 
> and let me know if it's work for you (it does for me) and will do an
> update soon.
> 

Worked fine.

A suggestion. People being able to build kernels with egcs or other version,
would not be this suitable for another entry in /var/lib/rpm/alternatives,
named kgcc, and with priorities gcc-2.91.66, gcc-2.95.2, gcc-2.7.2.3, gcc-2.96 ?

-- 
Juan Antonio Magallon Lacarta                                 #> cd /pub
mailto:jamagallon@able.es                                     #> more beer

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
