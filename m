Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266615AbUBQVr7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 16:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266651AbUBQVpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 16:45:05 -0500
Received: from mho.net ([64.58.22.195]:59359 "EHLO sm1420")
	by vger.kernel.org with ESMTP id S266664AbUBQVn0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 16:43:26 -0500
Date: Tue, 17 Feb 2004 14:42:11 -0700 (MST)
From: Alex Belits <abelits@belits.com>
To: Linus Torvalds <torvalds@osdl.org>
cc: John Bradford <john@grabjohn.com>, viro@parcelfarce.linux.theplanet.co.uk,
       Jamie Lokier <jamie@shareable.org>, Marc <pcg@goof.com>,
       Marc Lehmann <pcg@schmorp.de>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: UTF-8 practically vs. theoretically in the VFS API (was: Re:
 JFS default behavior)
In-Reply-To: <Pine.LNX.4.58.0402171251130.2154@home.osdl.org>
Message-ID: <Pine.LNX.4.58.0402171407461.23115@sm1420.belits.com>
References: <Pine.LNX.4.58.0402161040310.30742@home.osdl.org>
 <20040216200321.GB17015@schmorp.de> <Pine.LNX.4.58.0402161205120.30742@home.osdl.org>
 <20040216222618.GF18853@mail.shareable.org> <Pine.LNX.4.58.0402161431260.30742@home.osdl.org>
 <20040217071448.GA8846@schmorp.de> <Pine.LNX.4.58.0402170739580.2154@home.osdl.org>
 <20040217163613.GA23499@mail.shareable.org> <20040217175209.GO8858@parcelfarce.linux.theplanet.co.uk>
 <20040217192917.GA24311@mail.shareable.org> <20040217195348.GQ8858@parcelfarce.linux.theplanet.co.uk>
 <200402172035.i1HKZM4j000154@81-2-122-30.bradfords.org.uk>
 <Pine.LNX.4.58.0402171251130.2154@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Feb 2004, Linus Torvalds wrote:

> In short: even if you hate Unicode with a passion, and refuse to touch it
> and think standards are worthless, you should still use the same
> transformation that UTF-8 does to your idiotic character set of the day.
> Because the _transform_ makes sense regardless of character set encoding.

  Pretty much every charset other than Unicode does not NEED encoding
because it was already designed to work with existing system. The decision
to make the basic representation of charset full of zero bytes was the
reason that created the need for UTF-8. People who use other charsets may
not have planned for multilingual environments like they should've done,
but they aren't stupid enough to require someone to "bless" them with a
variable-length encoding.

-- 
Alex
