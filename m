Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135751AbRAGGBN>; Sun, 7 Jan 2001 01:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135763AbRAGGBE>; Sun, 7 Jan 2001 01:01:04 -0500
Received: from pizda.ninka.net ([216.101.162.242]:8596 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S135751AbRAGGAz>;
	Sun, 7 Jan 2001 01:00:55 -0500
Date: Sat, 6 Jan 2001 21:43:16 -0800
Message-Id: <200101070543.VAA24689@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: hadi@cyberus.ca
CC: ak@suse.de, greearb@candelatech.com, linux-kernel@vger.kernel.org,
        netdev@oss.sgi.com
In-Reply-To: <Pine.GSO.4.30.0101062253440.18916-100000@shell.cyberus.ca>
	(message from jamal on Sat, 6 Jan 2001 23:00:10 -0500 (EST))
Subject: Re: [PATCH] hashed device lookup (Does NOT meet Linus' sumission
 policy!)
In-Reply-To: <Pine.GSO.4.30.0101062253440.18916-100000@shell.cyberus.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date:   Sat, 6 Jan 2001 23:00:10 -0500 (EST)
   From: jamal <hadi@cyberus.ca>

   I think someone should just flush ifconfig down some toilet. a wrapper
   around "ip" to to give the same look and feel as ifconfig would be a good
   thing so that some stupid program that depends on ifconfig look and feel
   would be a good start.

I could not agree more.  This reminds me to do something I could not
justify before, making netlink be enabled in the kernel and
non-configurable.

I could almost, but not quite, justify it right now just because "ip"
is becomming standard and needs it.

   Not to stray from the subject, Ben's effort is still needed. I think real
   numbers are useful instead of claims like it "displayed faster"

See my previous email, if it's just slow because of some poorly coded
version of ifconfig, it does not justify the patch.  If only a
forcefully created "benchmark" can show some performance problem, that
is not an acceptable reason to champion this patch.  Ok?

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
