Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161042AbWARXNh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161042AbWARXNh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 18:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161043AbWARXNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 18:13:37 -0500
Received: from locomotive.csh.rit.edu ([129.21.60.149]:63298 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S1161042AbWARXNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 18:13:36 -0500
Message-ID: <43CECC7D.1090200@suse.com>
Date: Wed, 18 Jan 2006 18:17:17 -0500
From: Jeff Mahoney <jeffm@suse.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Damien Wyart <damien.wyart@free.fr>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc1 + reiser* from -rc1-mm1 : BUG with reiserfs
References: <20060118122631.GA12363@localhost.localdomain> <43CEC61E.2040500@suse.com> <200601190004.36549.rjw@sisk.pl>
In-Reply-To: <200601190004.36549.rjw@sisk.pl>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Rafael J. Wysocki wrote:
> On Wednesday, 18 January 2006 23:50, Jeff Mahoney wrote:
> }-- snip --{
>> Sigh. Ok. Back out the reiserfs patches
> 
> Those:
> 
> reiserfs-fix-is_reusable-bitmap-check-to-not-traverse-the-bitmap-info-array.patch
> reiserfs-clean-up-bitmap-block-buffer-head-references.patch
> reiserfs-move-bitmap-loading-to-bitmapc.patch
> reiserfs-on-demand-bitmap-loading.patch
> reiserfs-on-demand-bitmap-loading-fix.patch
> reiserfs-on-demand-bitmap-loading-warning-fix.patch

Just the on-demand bitmap stuff.

- -Jeff

- --
Jeff Mahoney
SUSE Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDzsx9LPWxlyuTD7IRAkkgAJ4vOU5rkF5U6G8tIWZQGBZBYdJCLwCfV9Mz
xSz+fH3fdZuN2gPScRpazT8=
=rz9K
-----END PGP SIGNATURE-----
