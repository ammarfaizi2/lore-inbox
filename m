Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265179AbUETQmT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265179AbUETQmT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 12:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265197AbUETQmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 12:42:19 -0400
Received: from turing-police.cirt.vt.edu ([128.173.54.129]:59602 "EHLO
	turing-police.cirt.vt.edu") by vger.kernel.org with ESMTP
	id S265179AbUETQmR (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 12:42:17 -0400
Message-Id: <200405201642.i4KGgDgJ000683@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: john weber <weber@sixbit.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Performance Tuning 
In-Reply-To: Your message of "Thu, 20 May 2004 12:05:15 -0000."
             <20040520120514.GA29540@sixbit.org> 
From: Valdis.Kletnieks@vt.edu
References: <20040520120514.GA29540@sixbit.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1163729809P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 20 May 2004 12:42:13 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1163729809P
Content-Type: text/plain; charset=us-ascii

On Thu, 20 May 2004 12:05:15 -0000, john weber <weber@sixbit.org>  said:

> Kernel compiles take 6m38s on my P4 2.8GHz (with HT enabled) and 
> 512 MB RAM as compared to 20-30 seconds reported by folks online. 
> I am running kernel 2.6.6.
> 
> While I understand that this varies with the config, I also don't 
> see why it should vary so much.  Does anyone have any pointers on 
> how I could best troubleshoot my performance?

Step 1: Buy a machine that has 16 CPUs and 32G of memory.

Step 2: cd /usr/src/linux-2.6.6 && make -j20

Step 3: Stand back :)

Seriously - the only way to do a kernel build in 20 seconds is to use 'make
-j20' or so, and have enough processors to handle it, and enough RAM so that
you can basically do the whole thing in the fin-core cache rather than beating
on the disk....


--==_Exmh_1163729809P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFArN/lcC3lWbTT17ARAqRnAKCYc675ICc/CEZjZkQFyZhju9ztywCfYPJG
sPpjbkUoI5Pj7bqoeiQoSV4=
=TmVE
-----END PGP SIGNATURE-----

--==_Exmh_1163729809P--
