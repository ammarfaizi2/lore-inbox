Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262477AbUKLAbm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262477AbUKLAbm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 19:31:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262419AbUKLA2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 19:28:49 -0500
Received: from ns1.g-housing.de ([62.75.136.201]:59078 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S262431AbUKLA1x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 19:27:53 -0500
Message-ID: <41940384.1000409@g-house.de>
Date: Fri, 12 Nov 2004 01:27:48 +0100
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Matt Domsch <Matt_Domsch@dell.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Pekka Enberg <penberg@gmail.com>,
       Greg KH <greg@kroah.com>
Subject: Re: Oops in 2.6.10-rc1 (almost solved)
References: <Pine.LNX.4.58.0411080951390.2301@ppc970.osdl.org> <418FDE1F.7060804@g-house.de> <419005F2.8080800@g-house.de> <41901DF0.8040302@g-house.de> <84144f02041108234050d0f56d@mail.gmail.com> <4190B910.7000407@g-house.de> <20041109164238.M12639@g-house.de> <Pine.LNX.4.58.0411091026520.2301@ppc970.osdl.org> <4191530D.8020406@g-house.de> <20041109234053.GA4546@lists.us.dell.com> <20041111224331.GA31340@lists.us.dell.com>
In-Reply-To: <20041111224331.GA31340@lists.us.dell.com>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Matt Domsch schrieb:
> 
> As Linus points out, those are the magic numbers in EDD for number of
> device entries stored.  Your BIOS seems to be reporting that is has
> more devices than it does, or the EDD assembly is horked in a way I
> have not yet deciphered.

actually, my BIOS is even to old for e.g. ACPI, with latest firmware
installed. i had no issues so far with the board/bios, but perhaps this is
no longer true. however, it's still strange that this thing is only
triggerd with you change and CONFIG_EDD=y.

> 
> I haven't been able to find a solution to your problem yet, and given
> some external time constraints I've got, won't be able to look into
> this again for another week or more.

nevermind then. as nobody else seem to be bothered by this i am happy with
the workarund (CONFIG_EDD=n) and since the lkml-archives exist we could
get back to it when it's bothering more people (n>1)

thank you for your time,
Christian.
- --
BOFH excuse #396:

Mail server hit by UniSpammer.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBlAOE+A7rjkF8z0wRAkyLAJ4uy4LYBHWk8Wxwr/heQRVm7VOXfwCfW30C
Zv1RdMYf1VOBEGkUnkQ+k0Q=
=f2hG
-----END PGP SIGNATURE-----
