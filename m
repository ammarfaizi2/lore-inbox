Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129431AbRAKBjD>; Wed, 10 Jan 2001 20:39:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129584AbRAKBio>; Wed, 10 Jan 2001 20:38:44 -0500
Received: from linuxcare.com.au ([203.29.91.49]:42002 "EHLO
	front.linuxcare.com.au") by vger.kernel.org with ESMTP
	id <S129431AbRAKBil>; Wed, 10 Jan 2001 20:38:41 -0500
From: Rusty Russell <rusty@linuxcare.com.au>
To: "David S. Miller" <davem@redhat.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Invalid Netfilter URL in Documentation/Changes in 2.4.0 
In-Reply-To: Your message of "Wed, 10 Jan 2001 01:49:32 -0800."
             <200101100949.BAA18698@pizda.ninka.net> 
Date: Thu, 11 Jan 2001 12:38:26 +1100
Message-Id: <E14GWh8-0007mu-00@halfway>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200101100949.BAA18698@pizda.ninka.net> you write:
>    Date: 	Tue, 9 Jan 2001 09:38:53 -0800
>    From: David Rees <dbr@spoke.nols.com>
> 
>    The link to http://www.samba.org/netfilter/iptables-1.1.1.tar.bz2 is 
>    invalid in 2.4.0, this patch simply removes the link.
> 
> Thanks, I've applied this.

My bad.  Please revert, and apply this (the samba.org guys are now the
same form as the others):

--- working-2.4.0/Documentation/Changes.~1~	Tue Jan  2 05:00:04 2001
+++ working-2.4.0/Documentation/Changes	Thu Jan 11 12:36:31 2001
@@ -335,9 +335,9 @@
 
 Netfilter
 ---------
-o  <http://netfilter.filewatcher.org/iptables-1.1.1.tar.bz2>
-o  <http://www.samba.org/netfilter/iptables-1.1.1.tar.bz2>
-o  <http://netfilter.kernelnotes.org/iptables-1.1.1.tar.bz2>
+o  <http://netfilter.filewatcher.org/iptables-1.2.tar.bz2>
+o  <http://netfilter.samba.org/iptables-1.2.tar.bz2>
+o  <http://netfilter.kernelnotes.org/iptables-1.2.tar.bz2>
 
 Ip-route2
 ---------

Cheers,
--
http://linux.conf.au The Linux conference Australia needed.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
