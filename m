Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262337AbVCVH0K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262337AbVCVH0K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 02:26:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262210AbVCVHZG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 02:25:06 -0500
Received: from 1-1-10-11a.has.sth.bostream.se ([82.182.131.18]:29912 "EHLO
	DeepSpaceNine.stesmi.com") by vger.kernel.org with ESMTP
	id S262263AbVCVHT6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 02:19:58 -0500
Message-ID: <423FC706.4020407@stesmi.com>
Date: Tue, 22 Mar 2005 08:19:34 +0100
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mws <mws@twisted-brains.org>
CC: Pavel Machek <pavel@suse.cz>,
       Phillip Lougher <phillip@lougher.demon.co.uk>,
       Paulo Marques <pmarques@grupopie.com>, Andrew Morton <akpm@osdl.org>,
       greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2/2] SquashFS
References: <20050314170653.1ed105eb.akpm@osdl.org> <A572579D-94EF-11D9-8833-000A956F5A02@lougher.demon.co.uk> <20050314190140.5496221b.akpm@osdl.org> <423727BD.7080200@grupopie.com> <20050321101441.GA23456@elf.ucw.cz> <423EEEC2.9060102@lougher.demon.co.uk> <20050321190044.GD1390@elf.ucw.cz> <423F4B88.8020504@twisted-brains.org>
In-Reply-To: <423F4B88.8020504@twisted-brains.org>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira Milter 1.0.7; VAE 6.29.0.5; VDF 6.29.0.100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

> what do you need e.g. reiserfs 4 for? or jfs? or xfs? does not ext2/3
> the journalling job also?

Ext2 does not do journaling. Ext3 does.

>> Perhaps squashfs is good enough improvement over cramfs... But I'd
>> like those 4Gb limits to go away.
>>
> we all do - but who does really care about stupid 4Gb limits on embedded
> systems with e.g.
> 8 or 32 Mb maybe more of Flash Ram? really noboby

Then if this filesystem is specifically targeted ONLY on embedded
then that's reason for keeping it out-of-tree.

> if you want to have a squashfs for DVD images e.g. not 4.7Gb but 
> DualLayer ect., why do you complain?
> you are maybe not even - nor you will be - a user of squashfs. but there

But if a filesystem COULD be made to work for MORE users - why not?

I'm sure that more than a few might use it in some form if such a limit
is removed - why lock us into a corner that when we do get around
to fixing it we need a new on-disk format and then we might have a new
filesystem, squashfs2 or whatever.

> are many people outside that use
> squashfs on different platforms and want to have it integrated to
> mainline kernel. so why are you blocking?

I think that's because people see a potential in it that has a flaw
that should be taken care of so that MORE people can use it, and
not ONLY "embedded people with 8 or 32 MB".

Seriously, noone's flaming here - I think what people want is
for a limit to be removed, and that is not in my eyes a bad thing.

// Stefan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (MingW32)

iD8DBQFCP8cGBrn2kJu9P78RAsTnAKCfslYF0ez4Wkt5xgKs7AXXp1KlUgCgt0y/
pX+t5HtVhQ+EvIo667XaDBA=
=Q6RX
-----END PGP SIGNATURE-----
