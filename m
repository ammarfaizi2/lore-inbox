Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132284AbRAXFG6>; Wed, 24 Jan 2001 00:06:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132405AbRAXFGt>; Wed, 24 Jan 2001 00:06:49 -0500
Received: from linuxcare.com.au ([203.29.91.49]:16648 "EHLO
	front.linuxcare.com.au") by vger.kernel.org with ESMTP
	id <S132284AbRAXFGm>; Wed, 24 Jan 2001 00:06:42 -0500
From: Paul Mackerras <paulus@linuxcare.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14958.25201.508164.388346@diego.linuxcare.com.au>
Date: Wed, 24 Jan 2001 16:04:49 +1100 (EST)
To: l_indien@magic.fr, jma@netgem.com
Cc: callahan@maths.ox.ac.uk, jfree@sovereign.org, linux-kernel@vger.kernel.org
Subject: Re: Bug in ppp_async.c
In-Reply-To: <3A6E4DF1.EE691AF5@magic.fr>
In-Reply-To: <3A6E4DF1.EE691AF5@magic.fr>
X-Mailer: VM 6.75 under Emacs 20.4.1
Reply-To: paulus@linuxcare.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jo l'Indien writes:

> I found a bug in the 2.4.1-pre10 version of ppp_async.c
> 
> In fact, a lot of ioctl are not supported any more,
> whih make the pppd start fail.

I'll bet you're using an old pppd.  You need version 2.4.0 of pppd,
available from ftp://linuxcare.com.au/pub/ppp/, as documented in the
Documentation/Changes file.

> PS: sorry, but I don't know who is the actual maitainer of this
> driver...

Me.

-- 
Paul Mackerras, Open Source Research Fellow, Linuxcare, Inc.
+61 2 6262 8990 tel, +61 2 6262 8991 fax
paulus@linuxcare.com.au, http://www.linuxcare.com.au/
Linuxcare.  Support for the revolution.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
