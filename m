Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129532AbRAXJnj>; Wed, 24 Jan 2001 04:43:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130869AbRAXJn3>; Wed, 24 Jan 2001 04:43:29 -0500
Received: from linuxcare.com.au ([203.29.91.49]:15370 "EHLO
	front.linuxcare.com.au") by vger.kernel.org with ESMTP
	id <S130866AbRAXJnP>; Wed, 24 Jan 2001 04:43:15 -0500
From: Paul Mackerras <paulus@linuxcare.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14958.42045.576523.62083@argo.linuxcare.com.au>
Date: Wed, 24 Jan 2001 20:45:33 +1100 (EST)
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: l_indien@magic.fr, jma@netgem.com, jfree@sovereign.org,
        linux-kernel@vger.kernel.org
Subject: Re: Bug in ppp_async.c
In-Reply-To: <200101240701.f0O71OE110437@saturn.cs.uml.edu>
In-Reply-To: <14958.25201.508164.388346@diego.linuxcare.com.au>
	<200101240701.f0O71OE110437@saturn.cs.uml.edu>
X-Mailer: VM 6.75 under Emacs 20.4.1
Reply-To: paulus@linuxcare.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert D. Cahalan writes:

> Even Red Hat 7 only has the 2.3.11 version.
> 
> The 2.4.xx series is supposed to be stable. If there is any way
> you could add a compatibility hack, please do so.

Stable != backwards compatible to the year dot.  ppp-2.4.0 has been
out for over 5 months now.  Adding the compatibility stuff back in
would make the PPP subsystem much more complicated and less robust.
And pppd is not the only thing you would have to upgrade if you are
using a 2.4.0 with Red Hat 7.0 - I would expect that you would also at
least have to upgrade modutils, and switch over from ipchains to
iptables if you use the netfilter stuff.

Paul.

-- 
Paul Mackerras, Open Source Research Fellow, Linuxcare, Inc.
+61 2 6262 8990 tel, +61 2 6262 8991 fax
paulus@linuxcare.com.au, http://www.linuxcare.com.au/
Linuxcare.  Support for the revolution.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
