Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262384AbUKQUOj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262384AbUKQUOj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 15:14:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262381AbUKQUNB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 15:13:01 -0500
Received: from brmea-mail-3.Sun.COM ([192.18.98.34]:37055 "EHLO
	brmea-mail-3.sun.com") by vger.kernel.org with ESMTP
	id S262517AbUKQUJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 15:09:30 -0500
Date: Wed, 17 Nov 2004 15:09:05 -0500
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [patch] inotify: vfs_permission was replaced
In-reply-to: <1100719052.4981.4.camel@betsy.boston.ximian.com>
To: Robert Love <rml@novell.com>
Cc: Christoph Hellwig <hch@infradead.org>, ttb@tentacle.dhs.org,
       linux-kernel@vger.kernel.org
Message-id: <419BAFE1.7030500@sun.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <1100710677.6280.2.camel@betsy.boston.ximian.com>
 <1100714560.6280.7.camel@betsy.boston.ximian.com>
 <20041117190850.GA11682@infradead.org>
 <1100718601.4981.2.camel@betsy.boston.ximian.com>
 <20041117191803.GA11830@infradead.org>
 <1100719052.4981.4.camel@betsy.boston.ximian.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Robert Love wrote:
> On Wed, 2004-11-17 at 19:18 +0000, Christoph Hellwig wrote:
> 
> 
>>No it doesn't.  Please try to understand the APIs before you're using them.
>>Just looking at the callers should give you an immediate clue.
> 
> 
> Maybe you should look at the code in question.  We actually want to
> perform the exact same sort of permission checks that, say, read
> performs.
> 
> 	Robert Love
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

use permission()

- --
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me,
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBm6/hdQs4kOxk3/MRAjFPAJ9tmyglXGvlhP4aYFzbX4uAmXIZkwCgjs86
mUksZfBEDIdncxVMmutvVGA=
=ei8c
-----END PGP SIGNATURE-----
