Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261188AbULHLc7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbULHLc7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 06:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261189AbULHLc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 06:32:59 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:19371 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S261188AbULHLc5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 06:32:57 -0500
Date: Wed, 8 Dec 2004 22:32:41 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Zou, Nanhai" <nanhai.zou@intel.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, tony.luck@intel.com,
       ak@suse.de, ralf@linux-mips.org, paulus@au.ibm.com,
       schwidefsky@de.ibm.com, Davem@davemloft.net
Subject: Re: [Compatibilty patch] sigtimedwait
Message-Id: <20041208223241.4ff5a60c.sfr@canb.auug.org.au>
In-Reply-To: <894E37DECA393E4D9374E0ACBBE7427013C9FB@pdsmsx402.ccr.corp.intel.com>
References: <894E37DECA393E4D9374E0ACBBE7427013C9FB@pdsmsx402.ccr.corp.intel.com>
X-Mailer: Sylpheed version 1.0.0beta3 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Wed__8_Dec_2004_22_32_41_+1100_H8AKtOeLZLjAwvX4"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Wed__8_Dec_2004_22_32_41_+1100_H8AKtOeLZLjAwvX4
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Wed, 8 Dec 2004 08:48:56 +0800 "Zou, Nanhai" <nanhai.zou@intel.com> wrote:
>
> 
> This patch also merges all 6 32 bit layer sys_rt_sigtimedwait in IA64,
> X86_64, PPC64, Sparc64, S390 and MIPS into 1 compat_rt_sigtimedwait.

I think compat_siginfo_t/struct compat_siginfo should be the preferred
name for the structure like all the other comptibility types.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__8_Dec_2004_22_32_41_+1100_H8AKtOeLZLjAwvX4
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBtuZi4CJfqux9a+8RAhf3AKCVrpVcPFML2USks10VnG0A82p8HwCfTBGc
SNaaUc7kf/evpRoMLMhmNI8=
=tYEe
-----END PGP SIGNATURE-----

--Signature=_Wed__8_Dec_2004_22_32_41_+1100_H8AKtOeLZLjAwvX4--
