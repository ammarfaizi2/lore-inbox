Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286303AbSA2Bie>; Mon, 28 Jan 2002 20:38:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287303AbSA2BiY>; Mon, 28 Jan 2002 20:38:24 -0500
Received: from foo-bar-baz.cc.vt.edu ([128.173.14.103]:51087 "EHLO
	foo-bar-baz.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S286303AbSA2BiJ>; Mon, 28 Jan 2002 20:38:09 -0500
Message-Id: <200201290137.g0T1bMqI021093@foo-bar-baz.cc.vt.edu>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4+dev
To: Oliver Xymoron <oxymoron@waste.org>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>,
        Josh MacDonald <jmacd@CS.Berkeley.EDU>,
        linux-kernel <linux-kernel@vger.kernel.org>, reiserfs-list@namesys.com,
        reiserfs-dev@namesys.com
Subject: Re: [reiserfs-list] Re: Note describing poor dcache utilization under high memory pressure 
In-Reply-To: Your message of "Mon, 28 Jan 2002 19:29:49 CST."
             <Pine.LNX.4.44.0201281918050.18405-100000@waste.org> 
From: Valdis.Kletnieks@vt.edu
X-Url: http://black-ice.cc.vt.edu/~valdis/
X-Face-Viewer: See ftp://cs.indiana.edu/pub/faces/index.html to decode picture 
X-Face: 34C9$Ewd2zeX+\!i1BA\j{ex+$/V'JBG#;3_noWWYPa"|,I#`R"{n@w>#:{)FXyiAS7(8t(
 ^*w5O*!8O9YTe[r{e%7(yVRb|qxsRYw`7J!`AM}m_SHaj}f8eb@d^L>BrX7iO[<!v4-0bVIpaxF#-)
 %9#a9h6JXI|T|8o6t\V?kGl]Q!1V]GtNliUtz:3},0"hkPeBuu%E,j(:\iOX-P,t7lRR#
In-Reply-To: <Pine.LNX.4.44.0201281918050.18405-100000@waste.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_2063465756P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 28 Jan 2002 20:37:22 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_2063465756P
Content-Type: text/plain; charset=us-ascii

On Mon, 28 Jan 2002 19:29:49 CST, Oliver Xymoron said:

> I think something more is needed, such as creating a minimal page table
> for the child process with read-only mappings to the current %EIP and %EBP
> pages in it. This gets us past the fork/exec hurdle. Without the exec, we
> copy over chunks when they're accessed as above in handle_mm_fault. But
> you can't actually _share_ the page tables without marking the pages
> themselves readonly.

Actually, you can.  But everybody agrees that vfork() was blecherous.
-- 
				Valdis Kletnieks
				Computer Systems Senior Engineer
				Virginia Tech


--==_Exmh_2063465756P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE8VfzRcC3lWbTT17ARAryCAJ9Q11mleP4L//ixL7zfE8nevEhKpwCaA60E
AKo3UKggReJ4fpsyKwgWKT8=
=8RDu
-----END PGP SIGNATURE-----

--==_Exmh_2063465756P--
