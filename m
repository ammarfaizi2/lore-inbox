Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbUA0Bm6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 20:42:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262765AbUA0Bm6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 20:42:58 -0500
Received: from pirx.hexapodia.org ([65.103.12.242]:60444 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S261298AbUA0Bm4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 20:42:56 -0500
Date: Mon, 26 Jan 2004 19:42:54 -0600
From: Andy Isaacson <adi@hexapodia.org>
To: Adam Sampson <azz@us-lot.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Encrypted Filesystem
Message-ID: <20040127014254.GA1379@hexapodia.org>
References: <OFA97B290B.67DE842E-ON87256E27.0061728C-86256E27.0061BB0E@us.ibm.com> <y2ar7xmkyqe.fsf@cartman.at.fivegeeks.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <y2ar7xmkyqe.fsf@cartman.at.fivegeeks.net>
User-Agent: Mutt/1.4.1i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 27, 2004 at 12:43:21AM +0000, Adam Sampson wrote:
> Michael A Halcrow <mahalcro@us.ibm.com> writes:
> >  - Userland filesystem-based (EncFS+FUSE, CryptoFS+LUFS)
> 
> Going off on a tangent...
> 
> There are all sorts of potentially-interesting things that could be
> done if Linux had a userspace filesystem mechanism included in the
> standard kernel -- as well as encryption, there's also network
> filesystems, various sorts of specialised caching (such as Zero
> Install), automounter-like systems, prototyping and so on.
> 
> Is there a technical reason that none of the userspace filesystem
> layers have been included in the stock kernel, or is it just that
> nobody's submitted any of them for inclusion yet?

There are a lot of subtle and not-so-subtle problems in this space.
For example, I really liked the paging example given in section 3.1 of
[Mazi2001].

[Mazi2001] "A toolkit for user-level file systems", David Mazieres,
    Proceedings of the 2001 USENIX Technical Conference
    available at http://www.fs.net/sfswww/pubs.html

-andy
