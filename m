Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129453AbQKXI6U>; Fri, 24 Nov 2000 03:58:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129971AbQKXI6J>; Fri, 24 Nov 2000 03:58:09 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:49160 "HELO mail.ocs.com.au")
        by vger.kernel.org with SMTP id <S129453AbQKXI57>;
        Fri, 24 Nov 2000 03:57:59 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Steven Lembark <lembark@jeeves.wrkhors.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: oddity introduced between 2.4.0-test10 & -test11 
In-Reply-To: Your message of "Thu, 23 Nov 2000 13:36:35 CDT."
             <200011231836.NAA22001@dizzy.wrkhors.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 24 Nov 2000 19:27:42 +1100
Message-ID: <944.975054462@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2000 13:36:35 -0500, 
Steven Lembark <lembark@jeeves.wrkhors.com> wrote:
>make[1]: Leaving directory `/usr/src/linux-2.4.0-test11/arch/i386/lib'
>cd /lib/modules/2.4.0-test11; \
>mkdir -p pcmcia; \
>find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{} pcmcia
>if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.0-test11; fi
>depmod: depmod.c:482: addksyms: Assertion `n_syms < 10000' failed.
>make: *** [_modinst_post] Error 134

Upgrade modutils.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
