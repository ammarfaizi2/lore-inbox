Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262785AbTJJOjq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 10:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262796AbTJJOjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 10:39:46 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:45707 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262785AbTJJOjW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 10:39:22 -0400
Date: Fri, 10 Oct 2003 15:39:20 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: statfs() / statvfs() syscall ballsup...
Message-ID: <20031010143920.GB28795@mail.shareable.org>
References: <Pine.LNX.4.44.0310091525200.20936-100000@home.osdl.org> <3F85ED01.8020207@redhat.com> <20031010002248.GE7665@parcelfarce.linux.theplanet.co.uk> <20031010044909.GB26379@mail.shareable.org> <16262.17185.757790.524584@charged.uio.no> <20031010123732.GA28224@mail.shareable.org> <16262.47147.943477.24070@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16262.47147.943477.24070@charged.uio.no>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
>      > I don't care about the cache semantics at all; what I care
>      > about is whether a returned stat() result may be stale.
> 
> Note that this too may be a per-file property.

Yes.  A flag from stat() or similar to say it's stale would make
sense.  Alternatively, a flag _into_ something like stat() to ask for
an up to date value, if that is possible.

I've often wondered if stat() couldn't be a bit more extensible with
some flags or extended attributes.

-- Jamie
