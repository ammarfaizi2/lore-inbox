Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269668AbUJADab@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269668AbUJADab (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 23:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269493AbUJADab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 23:30:31 -0400
Received: from out001pub.verizon.net ([206.46.170.140]:21648 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP id S269668AbUJADa2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 23:30:28 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.9-rc3
Date: Thu, 30 Sep 2004 23:30:26 -0400
User-Agent: KMail/1.7
Cc: Clemens Schwaighofer <cs@tequila.co.jp>, Jeff Garzik <jgarzik@pobox.com>,
       "Markus T." <markus@trippelsdorf.net>
References: <Pine.LNX.4.58.0409292036010.2976@ppc970.osdl.org> <415C80C1.8070406@pobox.com> <415CA7DB.7080203@tequila.co.jp>
In-Reply-To: <415CA7DB.7080203@tequila.co.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409302330.26396.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out001.verizon.net from [151.205.8.60] at Thu, 30 Sep 2004 22:30:27 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 30 September 2004 20:42, Clemens Schwaighofer wrote:
>-----BEGIN PGP SIGNED MESSAGE-----
>Hash: SHA1
>
>On 10/01/2004 06:55 AM, Jeff Garzik wrote:
>| There's definitely something else going on.  I don't see how you
>| can blame bz2 for downloading problems.  If this were true we
>| would see a _lot_ more problem reports than just one in >5 years.
>
>I fully agree. Since I can remember I always download the bz2
> version of a tar and I never ever had a problem with it. This
> sounds very mysterious, more like a memory or so problem? How else
> can you loose certain parts in bz2 ...
>
Beats me, Clemens.  But at the time, I got curious and the problem was 
100% repeatable using the bz2 src code files I had.  The third time I 
went after the srcs and patches to build that kernel, I got the .gz 
versions of both, and they worked first time.  Then I went back to 
the .bz2's and was seeing the same problem as the first 2 downloads 
gave me.  I mv'd that src file & patch, went after the .bz2's again 
(for the 3rd time), and that time it worked flawlessly.  Both the 2nd 
and 3rd dl's files had the exact same md5sum too.  Go figure.

I think I had a similar problem when I built kde3.3 using konstruct 
recently.  Most of kde is packed as .bz2 files.  I forget which src 
code file it was now but after the second failure to build it, I 
nuked the src code file and all its cookies which made it go after 
another copy, and that one worked as expected.

bz2 problem?  DamnedifIknow.  snilmerg maybe?  But it goes away if I 
stick to the .gz's.

>- --
>Clemens Schwaighofer - IT Engineer & System Administration
>==========================================================
>TEQUILA\Japan, 6-17-2 Ginza Chuo-ku, Tokyo 104-8167, JAPAN
>Tel: +81-(0)3-3545-7703            Fax: +81-(0)3-3545-7343
>http://www.tequila.co.jp
>==========================================================
>-----BEGIN PGP SIGNATURE-----
>Version: GnuPG v1.2.4 (GNU/Linux)
>Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org
>
>iD8DBQFBXKfbjBz/yQjBxz8RAgIVAJ9RZfjV6RJToqXeUAxxdV7ZdB15MwCfenaC
>k1qlJhSlBFT5OF0L3eeOgBY=
>=Voyg
>-----END PGP SIGNATURE-----

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.26% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
