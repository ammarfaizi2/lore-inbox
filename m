Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132902AbQKZXxn>; Sun, 26 Nov 2000 18:53:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132984AbQKZXxY>; Sun, 26 Nov 2000 18:53:24 -0500
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:57982 "EHLO
        pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
        id <S132902AbQKZXxP>; Sun, 26 Nov 2000 18:53:15 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] modutils 2.3.20 and beyond 
In-Reply-To: Your message of "Sun, 26 Nov 2000 16:36:55 PDT."
             <20001126163655.A1637@vger.timpanogas.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 27 Nov 2000 10:23:08 +1100
Message-ID: <1604.975280988@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Nov 2000 16:36:55 -0700, 
"Jeff V. Merkey" <jmerkey@vger.timpanogas.org> wrote:
>Keith,
>
>Please consider the attached patch for inclusion in all future versions
>of the modutils depmod program for compatiblity with RedHat and 
>RedHat derived Linux distributions.

I have a big problem with Redhat.  They make incompatible changes to
utilities, do not feed patches back to maintainers then expect the rest
of the world to follow their lead.  The -i and -m flags to modutils are
not the only example, I recently found IA64 and Sparc patches they had
added to modutils code and not bothered to tell me.  Other distributors
are much better about sending me patches, Debian and SuSe in particular
do the right thing.

Since "-F System.map" in modutils is equivalent to "-m System.map -i"
and works on all distributions, not just Redhat, the "-m -i" patch is
unnecessary.  Consider this my protest against bad habits by
distributors, they created the mess with their lack of communication
and they have to fix it.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
