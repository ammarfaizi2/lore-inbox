Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261438AbUKCGJc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261438AbUKCGJc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 01:09:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261440AbUKCGJc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 01:09:32 -0500
Received: from smtp.dei.uc.pt ([193.137.203.228]:49317 "EHLO smtp.dei.uc.pt")
	by vger.kernel.org with ESMTP id S261438AbUKCGJ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 01:09:27 -0500
Date: Wed, 3 Nov 2004 06:08:44 +0000 (WET)
From: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>
To: ipw2100-devel@lists.sourceforge.net
cc: linux-kernel@vger.kernel.org
Subject: ipw2100 and 2.6.10-rc1-bk12
In-Reply-To: <20041029014930.21ed5b9a.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0411030603500.23326@student.dei.uc.pt>
References: <20041029014930.21ed5b9a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-UC-FCTUC-DEI-MailScanner-Information: Please contact helpdesk@dei.uc.pt for more information
X-UC-FCTUC-DEI-MailScanner: Found to be clean
X-MailScanner-From: marado@student.dei.uc.pt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Greetings,

I was trying to compile Linux Kernel 2.6.10-rc1-bk12 and ipw2100-0.58, but got this compiling errors:

drivers/net/wireless/ipw2100/ipw2100.c: In function `ipw2100_pci_init_one':
drivers/net/wireless/ipw2100/ipw2100.c:6610: error: too many arguments to function `pci_restore_state'
drivers/net/wireless/ipw2100/ipw2100.c: In function `ipw2100_suspend':
drivers/net/wireless/ipw2100/ipw2100.c:6800: error: too many arguments to function `pci_save_state'
drivers/net/wireless/ipw2100/ipw2100.c: In function `ipw2100_resume':
drivers/net/wireless/ipw2100/ipw2100.c:6820: error: too many arguments to function `pci_restore_state'
make[4]: *** [drivers/net/wireless/ipw2100/ipw2100.o] Error 1
make[3]: *** [drivers/net/wireless/ipw2100] Error 2
make[2]: *** [drivers/net/wireless] Error 2
make[1]: *** [drivers/net] Error 2
make: *** [drivers] Error 2

I'm trying to compile this with gcc (GCC) 3.4.2 (Debian 3.4.2-3).

Any ideas? I can give any extra info you need...

Thanks in advance,
Marcos Marado

- -- 
/* *************************************************************** */
    Marcos Daniel Marado Torres	     AKA	Mind Booster Noori
    http://student.dei.uc.pt/~marado   -	  marado@student.dei.uc.pt
    () Join the ASCII ribbon campaign against html email, Microsoft
    /\ attachments and Software patents.   They endanger the World.
    Sign a petition against patents:  http://petition.eurolinux.org
/* *************************************************************** */
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Made with pgp4pine 1.76

iD8DBQFBiHXzmNlq8m+oD34RAvMMAJ4hG5qniSFyyng0KYbSojPHQGE7CwCghYSw
zMhLDoGmHtBfkKz6rk42fDU=
=i5f0
-----END PGP SIGNATURE-----

