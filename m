Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266634AbUBQVOp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 16:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266597AbUBQVKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 16:10:16 -0500
Received: from mail.shareable.org ([81.29.64.88]:8069 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S266619AbUBQVJ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 16:09:27 -0500
Date: Tue, 17 Feb 2004 21:09:19 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Alex Belits <abelits@phobos.illtel.denver.co.us>
Cc: Marc Lehmann <pcg@schmorp.de>, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: UTF-8 practically vs. theoretically in the VFS API (was: Re: JFS default behavior)
Message-ID: <20040217210919.GG24311@mail.shareable.org>
References: <04Feb13.163954est.41760@gpu.utcc.utoronto.ca> <200402150006.23177.robin.rosenberg.lists@dewire.com> <20040214232935.GK8858@parcelfarce.linux.theplanet.co.uk> <200402150107.26277.robin.rosenberg.lists@dewire.com> <Pine.LNX.4.58.0402141827200.14025@home.osdl.org> <20040216183616.GA16491@schmorp.de> <Pine.LNX.4.58.0402161040310.30742@home.osdl.org> <20040216200321.GB17015@schmorp.de> <Pine.LNX.4.58.0402161603420.10177@sm1420.belits.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402161603420.10177@sm1420.belits.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Belits wrote:
>   UTF-8 is dependent on Unicode, that is cumbersome, not user-expandable,

Ah, Alex, welcome back. :)

> This means, it's quite possible that this standard will be replaced
> by something better in the future

You mean like Unicode 4 will be replaced by Unicode 5 or something? :)

Seriously, if there was another standard encompassing all languages
and characters, why would they call it something different?

> and this is why poor design of Unicode is tolerated by users, and
> this is also why many people use non-Unicode-based charsets.

You've said this many times before, without explanation.

As far as I know, Unicode is a superset of all pre-existing computer
charsets used anywhere - but do feel free to correct me.

Unicode does have its problems - but what possible advantage does
_any_ known non-Unicode charset have over Unicode, apart from space saving?

You mention that Unicode doesn't well support language identification.
This is true - but the non-Unicode charsets (koi8-r etc.) don't
support that either!  Or do they?

>   And this is perfectly fine. Displaying and editing multilingual text is
> a user interface issue, that kernel should not be involved in.

Actually the kernel does have a line editor which needs to know a little.

>   I can point at the example of this "solution" that happened years ago
> when UCS-2 was all the rage, and it got hardcoded and enforced by NTFS
> and everything that handles it. Who is laughing about that decision now?

We are all laughing ;)

-- Jamie
