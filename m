Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261897AbUJYPdl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261897AbUJYPdl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 11:33:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261985AbUJYPdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 11:33:33 -0400
Received: from brmea-mail-3.Sun.COM ([192.18.98.34]:54499 "EHLO
	brmea-mail-3.sun.com") by vger.kernel.org with ESMTP
	id S261967AbUJYPaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 11:30:16 -0400
Date: Mon, 25 Oct 2004 11:30:06 -0400
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [PATCH 8/28] VFS: Remove MNT_EXPIRE support
In-reply-to: <20041025151621.GA1805@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       raven@themaw.net
Message-id: <417D1BFE.6070800@sun.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 0.8 (X11/20040918)
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <10987153211852@sun.com> <10987153522992@sun.com>
 <20041025150446.GB1603@infradead.org> <417D17C0.3010202@sun.com>
 <20041025151621.GA1805@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Christoph Hellwig wrote:
> On Mon, Oct 25, 2004 at 11:12:00AM -0400, Mike Waychison wrote:
> 
>>-----BEGIN PGP SIGNED MESSAGE-----
>>Hash: SHA1
>>
>>Christoph Hellwig wrote:
>>
>>>On Mon, Oct 25, 2004 at 10:42:32AM -0400, Mike Waychison wrote:
>>>
>>>
>>>>Drop support for MNT_EXPIRE (flag to umount(2)).  Nobody was using it and it
>>>>didn't fit into the new expiry framework.
>>>
>>>
>>>umm, this is a user API, you can't simply drop it.
>>>
>>
>>Is anybody using it though?
> 
> 
> doesn't matter much.  Maybe Sun likes deliberately breaking user ABIs in
> Solaris, but in Linux we certainly don't.

I wouldn't know, I only play with Linux ;)

> 
> 
>>Hmm.  I'll think about it a while to figure out how to map this
>>functionality to the new expire semantics.  Any suggestions?
> 
> 
> Hey, it's you who wants the new semantics.  And you didn't even explain
> them in detail.
> 

Hmm.. I think some bits of the series bounced.  Let me look.

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

iD8DBQFBfRv+dQs4kOxk3/MRAru8AJ9EPceeBwWKUzCAKoAcqkGxcU79gACfROFU
uLiWsbIGSl0AVX3rMf9sdeI=
=dXgV
-----END PGP SIGNATURE-----
