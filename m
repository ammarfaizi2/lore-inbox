Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262425AbUKLB10@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262425AbUKLB10 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 20:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262421AbUKLB1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 20:27:23 -0500
Received: from ns1.g-housing.de ([62.75.136.201]:12999 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S262378AbUKLB1R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 20:27:17 -0500
Message-ID: <41941171.2080401@g-house.de>
Date: Fri, 12 Nov 2004 02:27:13 +0100
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Matt Domsch <Matt_Domsch@dell.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pekka Enberg <penberg@gmail.com>, Greg KH <greg@kroah.com>
Subject: Re: Oops in 2.6.10-rc1 (almost solved)
References: <Pine.LNX.4.58.0411080951390.2301@ppc970.osdl.org> <418FDE1F.7060804@g-house.de> <419005F2.8080800@g-house.de> <41901DF0.8040302@g-house.de> <84144f02041108234050d0f56d@mail.gmail.com> <4190B910.7000407@g-house.de> <20041109164238.M12639@g-house.de> <Pine.LNX.4.58.0411091026520.2301@ppc970.osdl.org> <4191530D.8020406@g-house.de> <20041109234053.GA4546@lists.us.dell.com> <20041111224331.GA31340@lists.us.dell.com> <41940384.1000409@g-house.de> <Pine.LNX.4.58.0411111645110.2301@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0411111645110.2301@ppc970.osdl.org>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Linus Torvalds schrieb:
> 
> This is why I take random unexplained (but pinpointed) problems so 
> seriously. If it wasn't as apparently random, we could file it under 
> "known problem" and decide to try to fix it later. As it is, it's filed 
> under "known cause", but since we don't know _why_, it might cause totally 
> different problems on another machine, and that just makes it too painful 
> for words. 

just after sending my last mail i too (re)thought about this and i'd have
begged Matt to revert the patch if it was not *only* me having this issue.

but i can see your point here and i appreciate your decision.

> So the changeset is reverted for now in the current -bk tree, and I'll 
> make a -rc2 this weekend and hope that we can stabilize for 2.6.10.

yay!

thanks,
Christian.
- --
BOFH excuse #96:

Vendor no longer supports the product
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBlBFw+A7rjkF8z0wRAld5AJ40MjbzFbVXepXkJr1tLZCvYy7z2QCeMYCe
QQyekHBs1cjuebPZTEuPZZ0=
=wwF6
-----END PGP SIGNATURE-----
