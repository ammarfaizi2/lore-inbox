Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261496AbVFZRvs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261496AbVFZRvs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 13:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261511AbVFZRvs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 13:51:48 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:12557 "EHLO
	ninja.slaphack.com") by vger.kernel.org with ESMTP id S261496AbVFZRvo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 13:51:44 -0400
Message-ID: <42BEEB2E.3060100@slaphack.com>
Date: Sun, 26 Jun 2005 12:51:42 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050325)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Hans Reiser <reiser@namesys.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <42B831B4.9020603@pobox.com> <42B87318.80607@namesys.com> <20050621202448.GB30182@infradead.org> <42B8B9EE.7020002@namesys.com> <42B8BB5E.8090008@pobox.com> <42B8E834.5030809@slaphack.com> <20050622053656.GB28228@infradead.org> <42B91764.1080208@slaphack.com> <20050626165246.GB18942@infradead.org> <42BEE430.7010505@slaphack.com> <20050626172816.GB19630@infradead.org>
In-Reply-To: <20050626172816.GB19630@infradead.org>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Christoph Hellwig wrote:
> On Sun, Jun 26, 2005 at 12:21:52PM -0500, David Masover wrote:
> 
>>I seem to remember the comment was more about hardcoded ID tables.
>>
>>And this was the generic ID code database, which is now maintained out
>>of the kernel:
>>
>>/usr/share/misc/pci.ids
>>	A list of all known PCI ID's (vendors, devices, classes and sub-classes).
>>
>>That is what I was referring to, that used to be in the kernel.
> 
> 
> And you once again showed that you don't understand what you're talking
> about.  Said database is a pci id to name mapping, which is completely
> irrelevant for any driver.  For things like your example there's very
> little thing you can do but hardcoding a set of pci ids in one way or
> another.

I hope I admitted ahead of time that I don't understand what I'm talking
about.  For the record -- in this particular example, I don't.

But, the distinction is irrelevant.  PCI id to name mapping used to be
(I think?) in the kernel, it was ugly.  It may not have been where the
chainsaw comment was, though.

>>What this has to do with is whether you believe that it's better to keep
>>code out until it's perfectly clean, or to let in code that has some
> 
> 
> I doesn't need to be perfect, we just need it in a reasonable state and
> have a buying that it's going to continue to evolve in the rigýt direction.
> 
> And we're are very far from both of them in this ccase.

I believe that we are closer to both of those than much of what's
already in the kernel.  Sorry I picked such a bad example, though.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQr7rLngHNmZLgCUhAQIl7A//QTNclAuPe0Q+qzZjT7uMXeWXVgxlKGbR
cif4g55qtafpCA0m4/SkLYUmXpAL9Il384tCSK3vvnK7w8bQjGMCGk+xBeWQrDOC
qvuyu+GOaZh+jCeo25IMm5rQRyxrsFb9d+0r+mclN2MDBmzn3l/lMiAIFq6NnlxZ
gP0dOrCGpG1LXohfRhxLTphcmG1UMX/q7WbSSOCNAIMOxoqH2ez0ahdkJ44K+L45
hyMDtDugKCMeJw5r0No8RFl37h6bES/Q3DRv6Q1OQjbk4NYUKo9xCt69ypIvYRLJ
SSNE63CRIjOiOn2sgii1q5kwNj+nShnMrl7bBTjtslMLoariWRPJwswwxMPJh6Nv
xlovTxJKQnmg++KkJSZ6eDc7oCQapcGjeVxRCryHTIphuJ0OgRpw7xM4fsmOSj5R
ruE1XrJZADage92NaozNvCASDh9wLdnkJG9cepJVMsZTb/emDQ54UbOv3yqwtHEm
IbKnDNdSUVs0sgnLErWjRiQjfTh2xn0jof60mquVLufcJ0Ev9n7vWDTUBgKsFLVh
xU4n9y+GWDqT31nql+si+pEJlBeYQCt4Sz9aci7Sni+sVDv929HnRbf4T9GTi99J
5RumBvrBRdfbo/SJos4ttxEQDxUFbIc92UJtYESyLzwH1SIl8lihqfN+fP/oPDdf
unJVGXcgnMQ=
=BJ6I
-----END PGP SIGNATURE-----
