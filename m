Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129485AbRAXSDv>; Wed, 24 Jan 2001 13:03:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129842AbRAXSDl>; Wed, 24 Jan 2001 13:03:41 -0500
Received: from tools.cfourusa.com ([209.254.33.11]:64910 "EHLO tools.c4usa.com")
	by vger.kernel.org with ESMTP id <S129485AbRAXSD2>;
	Wed, 24 Jan 2001 13:03:28 -0500
Message-ID: <020001c0862f$e6535620$1a21fed1@ASHAMAN>
From: "Dan Egli" <dan@frankenstein-cpu.com>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <14958.25201.508164.388346@diego.linuxcare.com.au><200101240701.f0O71OE110437@saturn.cs.uml.edu> <14958.42045.576523.62083@argo.linuxcare.com.au>
Subject: Re: Bug in ppp_async.c
Date: Wed, 24 Jan 2001 11:03:04 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I do ppp using 2.4.0 w/ redhat 7 now, no upgrades besides modultils and the
kernel :>
-- Dan Egli
-- Network Administrator / President
-- Frankenstein Computers
-- 801-671-7875
----- Original Message -----
From: "Paul Mackerras" <paulus@linuxcare.com.au>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: <l_indien@magic.fr>; <jma@netgem.com>; <jfree@sovereign.org>;
<linux-kernel@vger.kernel.org>
Sent: Wednesday, January 24, 2001 2:45 AM
Subject: Re: Bug in ppp_async.c


> Albert D. Cahalan writes:
>
> > Even Red Hat 7 only has the 2.3.11 version.
> >
> > The 2.4.xx series is supposed to be stable. If there is any way
> > you could add a compatibility hack, please do so.
>
> Stable != backwards compatible to the year dot.  ppp-2.4.0 has been
> out for over 5 months now.  Adding the compatibility stuff back in
> would make the PPP subsystem much more complicated and less robust.
> And pppd is not the only thing you would have to upgrade if you are
> using a 2.4.0 with Red Hat 7.0 - I would expect that you would also at
> least have to upgrade modutils, and switch over from ipchains to
> iptables if you use the netfilter stuff.
>
> Paul.
>
> --
> Paul Mackerras, Open Source Research Fellow, Linuxcare, Inc.
> +61 2 6262 8990 tel, +61 2 6262 8991 fax
> paulus@linuxcare.com.au, http://www.linuxcare.com.au/
> Linuxcare.  Support for the revolution.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
