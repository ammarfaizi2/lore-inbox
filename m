Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751544AbWA0Swv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751544AbWA0Swv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 13:52:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751542AbWA0Swv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 13:52:51 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:30084 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751541AbWA0Swu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 13:52:50 -0500
Message-Id: <200601271852.k0RIqaC0023706@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Gerold van Dijk <gerold@sicon-sr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: traceroute bug ? 
In-Reply-To: Your message of "Fri, 27 Jan 2006 15:38:23 -0300."
             <000601c62370$db00cd50$1701a8c0@gerold> 
From: Valdis.Kletnieks@vt.edu
References: <000601c62370$db00cd50$1701a8c0@gerold>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1138387956_3087P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 27 Jan 2006 13:52:36 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1138387956_3087P
Content-Type: text/plain; charset=us-ascii

On Fri, 27 Jan 2006 15:38:23 -0300, Gerold van Dijk said:
> Why can I NOT do a traceroute specifically within my own (sub)network
> 
> 207.253.5.64/27
> 
> with any distribution of Linux??

OK.. I'll bite.  What happens when you try?  And why are you posting here - is
there *any* evidence that there is a Linux kernel bug involved?

The output of 'ifconfig' and 'netstat -r -n' would likely be helpful, as would
proof that the host(s) you're tracerouting from and to are *not* running a
firewall that interferes with the way traceroute functions. (It's amazing how
many people block all ICMP, then wonder why traceroute doesn't work... ;)

Watching the wire with 'tcpdump' and/or 'ethereal' can also help....



--==_Exmh_1138387956_3087P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFD2mv0cC3lWbTT17ARAtFdAJ9Tyit2+KAfBAD4bZnvdmrZ0FiB+gCeM6aM
E4EI/m6r4M3bJklg1CGNlLQ=
=UxAC
-----END PGP SIGNATURE-----

--==_Exmh_1138387956_3087P--
