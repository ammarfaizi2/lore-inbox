Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135353AbQLOA3J>; Thu, 14 Dec 2000 19:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135352AbQLOA3B>; Thu, 14 Dec 2000 19:29:01 -0500
Received: from smtp02.mrf.mail.rcn.net ([207.172.4.61]:33694 "EHLO
	smtp02.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S135292AbQLOA2w>; Thu, 14 Dec 2000 19:28:52 -0500
Date: Thu, 14 Dec 2000 18:58:23 -0500 (EST)
From: "Mohammad A. Haque" <mhaque@haque.net>
To: "David S. Miller" <davem@redhat.com>
cc: <ionut@cs.columbia.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: ip_defrag is broken (was: Re: test12 lockups -- need feedback)
In-Reply-To: <Pine.LNX.4.30.0012141746380.1220-100000@viper.haque.net>
Message-ID: <Pine.LNX.4.30.0012141856530.1368-100000@viper.haque.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Problem only happens when ip_conntrack is loaded.

On Thu, 14 Dec 2000, Mohammad A. Haque wrote:

> I do the following....
>
> sudo modprobe iptable_nat
>
> Module                  Size  Used by
> iptable_nat            17440   0 (unused)
> ip_conntrack           19808   1 [iptable_nat]
> ip_tables              12320   3 [iptable_nat]
>
>
> Oops start flying by when I access via NFS.
>
> If you need the actual Oops messages we're gonna have to get someone
> who can setup a serial console.
>

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
