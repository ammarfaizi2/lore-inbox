Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261689AbVCERlb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261689AbVCERlb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 12:41:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261702AbVCERla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 12:41:30 -0500
Received: from locomotive.csh.rit.edu ([129.21.60.149]:44625 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S261689AbVCERkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 12:40:02 -0500
Message-ID: <4229EF97.50403@suse.com>
Date: Sat, 05 Mar 2005 12:42:47 -0500
From: Jeff Mahoney <jeffm@suse.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, sds@epoch.ncsc.mil,
       chrisw@osdl.org
Subject: Re: [PATCH 1/4] vfs: adds the S_PRIVATE flag and adds use to security
References: <20050304195204.GA19711@locomotive.unixthugs.org> <20050304212839.1d5aca4c.akpm@osdl.org>
In-Reply-To: <20050304212839.1d5aca4c.akpm@osdl.org>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Bogosity: No, tests=bogofilter, spamicity=0.000000, version=0.92.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Andrew Morton wrote:
> Jeffrey Mahoney <jeffm@suse.com> wrote:
> 
>> This patch adds an S_PRIVATE flag to inode->i_flags to mark an inode as
>> filesystem-internal. As such, it should be excepted from the security
>> infrastructure to allow the filesystem to perform its own access control.
> 
> 
> OK, thanks.  I'll assume that the other three patches are unchanged.
> 
> I don't think we've heard from the SELinux team regarding these patches?
> 
> (See http://www.zip.com.au/~akpm/linux/patches/stuff/selinux-reiserfs/)

That's correct, the others are unchanged.

- -Jeff

- --
Jeff Mahoney
SuSE Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCKe+XLPWxlyuTD7IRApGeAJ9UWMIQSV1WlKlJg1Ml/hP36zSW0ACePTDW
qGUzKyItFVw9DFp9UoyaNHQ=
=LdAr
-----END PGP SIGNATURE-----
