Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261314AbVFMCFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261314AbVFMCFe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 22:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261315AbVFMCFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 22:05:34 -0400
Received: from h80ad2736.async.vt.edu ([128.173.39.54]:58628 "EHLO
	h80ad2736.async.vt.edu") by vger.kernel.org with ESMTP
	id S261314AbVFMCF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 22:05:27 -0400
Message-Id: <200506130204.j5D24EOE005565@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Willy Tarreau <willy@w.ods.org>
Cc: Denis Vlasenko <vda@ilport.com.ua>,
       "David S. Miller" <davem@davemloft.net>, xschmi00@stud.feec.vutbr.cz,
       alastair@unixtrix.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] fix small DoS on connect() (was Re: BUG: Unusual TCP Connect() results.) 
In-Reply-To: Your message of "Sun, 12 Jun 2005 20:14:25 +0200."
             <20050612181425.GA11284@alpha.home.local> 
From: Valdis.Kletnieks@vt.edu
References: <42A9C607.4030209@unixtrix.com> <200506122010.33075.vda@ilport.com.ua> <20050612173614.GA11157@alpha.home.local> <200506122047.07257.vda@ilport.com.ua>
            <20050612181425.GA11284@alpha.home.local>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1118628251_24934P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 12 Jun 2005 22:04:12 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1118628251_24934P
Content-Type: text/plain; charset=us-ascii

On Sun, 12 Jun 2005 20:14:25 +0200, Willy Tarreau said:
> On Sun, Jun 12, 2005 at 08:47:07PM +0300, Denis Vlasenko wrote:

> > Very nice. BTW, is there any real world applications which
> > ever used this?
> 
> Not that I'm aware of, but that does not mean they don't exist. Until
> yesterday, I even thought that it was never implemented. As most other
> systems don't implement it, the applications, if they exist, are Linux
> or BSD-dependant.

A more likely explanation is that there existed TOPS-20 or Multics code
that actually used that for something.  Remember that BSD and Linux both
came along long after RFC793 came out....

--==_Exmh_1118628251_24934P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCrOmbcC3lWbTT17ARAh6UAKDllrvzzA/u7DLz7U465OhXZSqJLACg8e8B
SVOuvr28yBxqHicG3qQptUg=
=Bwr2
-----END PGP SIGNATURE-----

--==_Exmh_1118628251_24934P--
