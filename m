Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261311AbULWWQ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbULWWQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 17:16:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261312AbULWWQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 17:16:26 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:23463 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261311AbULWWQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 17:16:20 -0500
Message-ID: <41CB43BA.3050804@comcast.net>
Date: Thu, 23 Dec 2004 17:16:26 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Amon Ott <ao@rsbac.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: on-access events?
References: <41C9C1C7.6030405@comcast.net> <200412231016.25967.ao@rsbac.org>
In-Reply-To: <200412231016.25967.ao@rsbac.org>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I'm looking for a hint on which will possibly go into mainline kernel,
if any.  Right now there's supposedly a few things built on Dazuko, like
Clamuko (ClamAV on-access scanning); but I've yet to really encounter
anything aside from that that use Dazuko so :)

I'm thinking of a lot of things that can be done with on-access control
from userspace.

RSBAC and LSM seem to do almost the same thing, except that RSBAC
actually comes with a lot of modules to use it (LSM/SELinux are separate
projects, but both integrated into the kernel, AFAIK).  I don't see
RSBAC going into mainline; I don't know which is better though, LSM or
RSBAC.  This brings to mind pointless and random proof-of-concept tasks,
such as porting SELinux to RSBAC; or porting LSM to RSBAC (as an rsbac
module), or RSBAC to LSM (as an lsm module).

Amon Ott wrote:
| On Mittwoch, 22. Dezember 2004 19:49, John Richard Moser wrote:
|
|>What kinds of on-access event driving is there for Linux?  I'm
|
| looking
|
|>at Dazuko[1] right now, but not sure about what else is out there.
|
| I'm
|
|>sure I've seen several; is there anything in the kernel?
|
|
| Besides the LSM interface in 2.6 kernels there is also the RSBAC
| framework for 2.4 and 2.6, where you can register from kernel modules
| at runtime, http://www.rsbac.org.
|
| Dazuko plus caching has also been integrated as RSBAC module.
|
| Amon.

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBy0O6hDd4aOud5P8RAt/eAJ9y8cGnbqggMLgT1pGQ3MsF3d/uagCgi/se
uwj+n448vDMislspw7CndQQ=
=ljdg
-----END PGP SIGNATURE-----
