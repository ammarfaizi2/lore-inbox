Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262691AbULPPbW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262691AbULPPbW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 10:31:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262694AbULPPbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 10:31:22 -0500
Received: from mailr.eris.qinetiq.com ([128.98.1.9]:43924 "HELO
	mailr.qinetiq-tim.net") by vger.kernel.org with SMTP
	id S262691AbULPPbT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 10:31:19 -0500
From: Mark Watts <m.watts@eris.qinetiq.com>
Organization: QinetiQ
To: linux-kernel@vger.kernel.org
Subject: Re: 3TB disk hassles
Date: Thu, 16 Dec 2004 15:37:02 +0000
User-Agent: KMail/1.6.1
Cc: Neil Conway <nconway_kernel@yahoo.co.uk>
References: <20041216145229.29167.qmail@web26502.mail.ukl.yahoo.com>
In-Reply-To: <20041216145229.29167.qmail@web26502.mail.ukl.yahoo.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200412161537.02804.m.watts@eris.qinetiq.com>
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.29.0.5; VDF: 6.29.0.19; host: mailr.qinetiq-tim.net)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


> Howdy...
>
> After much banging of heads on walls, I am throwing in the towel and
> asking the experts ;-) ... To cut a long story short:
>
> Is it possible to make a 3TB disk work properly in Linux?
>
> Our "disk" is 12x300GB in RAID5 (with 1 hot-spare) on a 3ware 9500-S12,
> so it's actually 2.7TiB ish.  It's also /dev/sda - i.e., the one and
> only disk in the system.
>
> Problems are arising due to the 32-bit-ness of normal partition tables.
>  I can use parted to make a 2.7TB partition (sda4), and
> /proc/partitions looks fine until a reboot, whereupon the top bits are
> lost and the big partition looks like a 700GB partition instead of a
> 2.7TB one; this is a bad thing ;-)
>
> I've had my hopes raised by GPT, but after more reading it appears this
> doesn't work on vanilla x86 PCs.
>
> Tips gratefully received.
>
> Neil
>
> PS: not on-list; I'll be reading the real-time archivers, but CCs of
> any replies would be appreciated.

Are you sure your card supports creating a single volume in excess of 2TB? 
Some cards have such a limit, although you can create many 2TB volumes on the 
same card.

Mark.

- -- 
Mark Watts
Senior Systems Engineer
QinetiQ Trusted Information Management
Trusted Solutions and Services group
GPG Public Key ID: 455420ED

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBwaueBn4EFUVUIO0RAhtLAKCK6ZcujlH1LGQ4SMssXlhoiifRqACgykSR
uXt8wfwTM2N6nxPBOFNaGtc=
=F7JI
-----END PGP SIGNATURE-----
