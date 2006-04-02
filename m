Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750779AbWDBWfI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbWDBWfI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 18:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbWDBWfI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 18:35:08 -0400
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:59780 "EHLO
	blue-labs.org") by vger.kernel.org with ESMTP id S1750779AbWDBWfH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 18:35:07 -0400
Message-ID: <44305193.5080408@kalifornia.com>
Date: Sun, 02 Apr 2006 15:34:59 -0700
From: Ben Ford <ben@kalifornia.com>
User-Agent: Mail/News 1.5 (X11/20060401)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Who wants to test cracklinux??
References: <20060328221223.80753cab.letterdrop@gmx.de> <20060328224929.GC5760@elf.ucw.cz>
In-Reply-To: <20060328224929.GC5760@elf.ucw.cz>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Pavel Machek wrote:
> Hi!
>> I've written a small kernel module & shared object for kernel 2.6 to
>> enable the following for normal users:
>>
>> - inb()/outb()... via a wrapper function
> ioperm() does that already, no? You mean, you enable it for non-root,
> too? That's security hole.

My OS development classes have a lab of machines that run entirely as
root just for these reasons.  I think it's valid to allow these
operations as non-root in certain situations.  It is better than
running *everything* as root, no?

- -b

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEMFGSInEozL1f7FIRAif7AJ41yzdVRHpiGU3Mqy8ef3aZ4TGNVACfYyED
xfZzMo2d5RFO80ciQ1YSo68=
=JKdo
-----END PGP SIGNATURE-----

