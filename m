Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130073AbQKBFu2>; Thu, 2 Nov 2000 00:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130459AbQKBFuS>; Thu, 2 Nov 2000 00:50:18 -0500
Received: from smtpnotes.altec.com ([209.149.164.10]:56329 "HELO
	smtpnotes.altec.com") by vger.kernel.org with SMTP
	id <S130073AbQKBFuM>; Thu, 2 Nov 2000 00:50:12 -0500
X-Lotus-FromDomain: ALTEC
From: Wayne.Brown@altec.com
To: "David S. Miller" <davem@redhat.com>
cc: npsimons@fsmlabs.com, garloff@suse.de, jamagallon@able.es,
        linux-kernel@vger.kernel.org
Message-ID: <8625698B.00200009.00@smtpnotes.altec.com>
Date: Wed, 1 Nov 2000 23:46:04 -0600
Subject: Re: Where did kgcc go in 2.4.0-test10 ?
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I've been following this kgcc discussion with interest for weeks now and there's
one thing that still puzzles me.  Everyone on both sides of the issue seems to
be saying that kgcc (AKA egcs 1.1.2) is used because the gcc versions shipped by
several vendors don't compile the kernel correctly.  What I haven't seen yet is
an explanation of why kgcc can't be used for compiling *everything* and why
another compiler even needs to be installed.  I'm using egcs-1.1.2 with the
latest kernel, binutils, modutils, etc. as well as applications like the latest
ppp and setiathome with no problems.  Instead of using two compilers, why not
stay with the older version for everything and not use the latest gcc for
anything until both the kernel and userland stuff can be compiled with it?

I'm not trying to fan the flames, just wondering why there's such an apparent
rush to upgrade to a newer gcc.  Everyone seems to be taking it for granted that
an upgrade is needed, but there's disagreement on which version to use.  Why do
we need to upgrade the compiler at all right now?


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
