Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135371AbRDLWY5>; Thu, 12 Apr 2001 18:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135366AbRDLWYs>; Thu, 12 Apr 2001 18:24:48 -0400
Received: from foo-bar-baz.cc.vt.edu ([128.173.14.103]:41856 "EHLO
	foo-bar-baz.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S135372AbRDLWYj>; Thu, 12 Apr 2001 18:24:39 -0400
Message-Id: <200104122224.f3CMOFB08457@foo-bar-baz.cc.vt.edu>
X-Mailer: exmh version 2.3.1 01/19/2001 with nmh-1.0.4+dev
To: Szabolcs Szakacsits <szaka@f-secure.com>
Cc: Rik van Riel <riel@conectiva.com.br>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Hugh Dickins <hugh@veritas.com>,
        linux-kernel@vger.kernel.org
Subject: Re: scheduler went mad? 
In-Reply-To: Your message of "Fri, 13 Apr 2001 01:02:21 +0200."
             <Pine.LNX.4.30.0104130009350.19377-100000@fs131-224.f-secure.com> 
From: Valdis.Kletnieks@vt.edu
X-Url: http://black-ice.cc.vt.edu/~valdis/
X-Face-Viewer: See ftp://cs.indiana.edu/pub/faces/index.html to decode picture 
X-Face: 34C9$Ewd2zeX+\!i1BA\j{ex+$/V'JBG#;3_noWWYPa"|,I#`R"{n@w>#:{)FXyiAS7(8t(
 ^*w5O*!8O9YTe[r{e%7(yVRb|qxsRYw`7J!`AM}m_SHaj}f8eb@d^L>BrX7iO[<!v4-0bVIpaxF#-)
 %9#a9h6JXI|T|8o6t\V?kGl]Q!1V]GtNliUtz:3},0"hkPeBuu%E,j(:\iOX-P,t7lRR#
In-Reply-To: <Pine.LNX.4.30.0104130009350.19377-100000@fs131-224.f-secure.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1181791386P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 12 Apr 2001 18:24:15 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1181791386P
Content-Type: text/plain; charset=us-ascii

On Fri, 13 Apr 2001 01:02:21 +0200, Szabolcs Szakacsits said:

> Not __alloc_pages() calls oom_kill() however do_page_fault(). Not the
> same. After the system tried *really* hard to get *one* free page and
> couldn't managed why loop forever? To eat CPU and waiting for

For what it's worth, this *IS NOT* the case I'm getting bit by:

While kswapd was hung, I already had (from /proc/meminfo)

MemFree:         34064 kB

I suspect that kswapd is getting hung spinning on some *specific*
requirement that it's falling short on?

/Valdis

--==_Exmh_1181791386P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: PGP 6.5.8
Comment: Exmh version 2.2 06/16/2000

iQA/AwUBOtYrD3At5Vm009ewEQLr/gCeM4oxoNeeYjdu2/Z+1xPuHWSb2oIAnRJS
tMimbGIA59+naI7CHPG9cjG5
=0bVM
-----END PGP SIGNATURE-----

--==_Exmh_1181791386P--
