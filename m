Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750739AbWFOXQT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbWFOXQT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 19:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbWFOXQT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 19:16:19 -0400
Received: from spock.bluecherry.net ([66.138.159.248]:39120 "EHLO
	spock.bluecherry.net") by vger.kernel.org with ESMTP
	id S1750739AbWFOXQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 19:16:18 -0400
Date: Thu, 15 Jun 2006 19:16:14 -0400
From: "Zephaniah E. Hull" <warp@aehallh.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16.20 build failure.
Message-ID: <20060615231613.GR6154@aehallh.com>
Mail-Followup-To: "Randy.Dunlap" <rdunlap@xenotime.net>,
	linux-kernel@vger.kernel.org
References: <20060615184635.GA6370@aehallh.com> <20060615124922.56e3b76b.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
In-Reply-To: <20060615124922.56e3b76b.rdunlap@xenotime.net>
X-Notice-1: Unsolicited Commercial Email (Aka SPAM) to ANY systems under
X-Notice-2: our control constitutes a $US500 Administrative Fee, payable
X-Notice-3: immediately.  By sending us mail, you hereby acknowledge that
X-Notice-4: policy and agree to the fee.
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 15, 2006 at 12:49:22PM -0700, Randy.Dunlap wrote:
> On Thu, 15 Jun 2006 14:46:35 -0400 Zephaniah E. Hull wrote:
> 
> > I got this while trying to prune the kernel down to fit into a zImage
> > for testing (have a box that's being stubborn about getting to even the
> > 'Uncompressing Linux...' message).
> > 
> >   LD      vmlinux
> > lib/lib.a(kobject_uevent.o): In function
> > `kobject_uevent':kobject_uevent.c:(.text+0x25b): undefined reference to
> > `uevent_seqnum'
> > :kobject_uevent.c:(.text+0x261): undefined reference to `uevent_seqnum'
> > :kobject_uevent.c:(.text+0x26d): undefined reference to `uevent_seqnum'
> > :kobject_uevent.c:(.text+0x273): undefined reference to `uevent_seqnum'
> > :kobject_uevent.c:(.text+0x3bf): undefined reference to `uevent_helper'
> > :kobject_uevent.c:(.text+0x3ce): undefined reference to `uevent_helper'
> > :kobject_uevent.c:(.text+0x3ed): undefined reference to `uevent_helper'
> > make[1]: *** [vmlinux] Error 1
> > 
> > 
> > The .config is attached.
> 
> There is a fix with the bugzilla for this bug.
> See http://bugzilla.kernel.org/show_bug.cgi?id=6306
> and the patch: http://bugzilla.kernel.org/attachment.cgi?id=7754&action=view
> 
> 2.6.16.20 is 10 days old, probably time for a new one with fixes. :)

NAK, the patch doesn't apply to 2.6.16.20, I'll see if I can figure out
why and get a working patch.

Zephaniah E. Hull.

-- 
	  1024D/E65A7801 Zephaniah E. Hull <warp@aehallh.com>
	   92ED 94E4 B1E6 3624 226D  5727 4453 008B E65A 7801
	    CCs of replies from mailing lists are requested.

lba32 requires bios support - which is common, and working bios support
which is slightly less common on older boxes
  -- Alan Cox

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEkeo9RFMAi+ZaeAERAk/bAKChIbNv3gszFsdRP+B4IlA02kF7HQCg66om
Yj8FW9TS389yi+LVo9fUAq8=
=Xp3q
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
