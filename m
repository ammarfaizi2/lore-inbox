Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265161AbTLKQ1P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 11:27:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265162AbTLKQ1P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 11:27:15 -0500
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:3323 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S265161AbTLKQ1O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 11:27:14 -0500
Content-Type: text/plain;
  charset="CP 1252"
From: Jesse Pollard <jesse@cats-chateau.net>
To: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: Linux GPL and binary module exception clause?
Date: Thu, 11 Dec 2003 10:26:38 -0600
X-Mailer: KMail [version 1.2]
Cc: Andre Hedrick <andre@linux-ide.org>, Valdis.Kletnieks@vt.edu,
       Peter Chubb <peter@chubb.wattle.id.au>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.10.10312100512480.3805-100000@master.linux-ide.org> <03121009022103.31567@tabby> <20031210203710.GC31300@thunk.org>
In-Reply-To: <20031210203710.GC31300@thunk.org>
MIME-Version: 1.0
Message-Id: <03121110263802.01687@tabby>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 December 2003 14:37, Theodore Ts'o wrote:
> On Wed, Dec 10, 2003 at 09:02:21AM -0600, Jesse Pollard wrote:
> > You are still deriving your binary from a GPL source when a module is
> > loaded. The kernel relocation symbols themselves are under GPL.
>
> Even if the relocation symbols are under GPL'ed (there is doubt
> whether such symbols are copyrightable --- since things like telephone
> numbers are not copyrightable, for example), there is still the issue
> that the user is the one which is loading the module, not the person
> writing and distributing the module.

As a nit - It is the person writing and distributing the binary that
determines the symbols used.

In any case, my phrasing was definitely poor.

((Though individual telephone numbers are not copyrightable, arrangements
of telephone numbers are... Or the copyright notice in my phone book is
bogus :-))

> And at this point, given that
> the GPL itself says that it's all about distribution, not about the
> use of the GPL'ed software, not to mention the fair use doctrine
> (trust me, the open source community does **not** want to narrow what
> is considered fair use), there isn't a problem.

I had no real problem with the actual load... Just the distribution of
the binary. To create the binary required access to the kernel sources
just to identify the interfaces. But if the Kernel includes can provide
the required separation... (I don't think they do, because other things are
missing, such as the actual routines).

I don't even have a big problem (other than distaste) to GPL shim modules
for binary drivers. I don't see this as much different than loadable
firmware. At least the shim (if properly written, that is) should be
able to adjust to the various options in a specific kernel build. And I do
have SOME possibility (however remote) to fix a slightly broken shim.
