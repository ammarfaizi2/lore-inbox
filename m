Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757290AbWK2AGi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757290AbWK2AGi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 19:06:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757412AbWK2AGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 19:06:38 -0500
Received: from smtp.osdl.org ([65.172.181.25]:26834 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1757290AbWK2AGh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 19:06:37 -0500
Date: Tue, 28 Nov 2006 16:05:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: Don Mullis <dwm@meer.net>
Cc: lkml <linux-kernel@vger.kernel.org>, Akinobu Mita <mita@miraclelinux.com>
Subject: Re: [PATCH 1/2 -mm] fault-injection: safer defaults, trivial
 optimization, cleanup
Message-Id: <20061128160557.4701c6a6.akpm@osdl.org>
In-Reply-To: <1164754245.2894.144.camel@localhost.localdomain>
References: <1164699866.2894.88.camel@localhost.localdomain>
	<20061128133754.bad99ddb.akpm@osdl.org>
	<1164754245.2894.144.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2006 14:50:45 -0800
Don Mullis <dwm@meer.net> wrote:

> On Tue, 2006-11-28 at 13:37 -0800, Andrew Morton wrote:
> 
> > We'd prefer one-patch-per-concept, please. This all sounds like about
> > six patches.
> 
> Understood.
> 
> > We _could_ merge this patch as-is, but it means that when this stuff
> > finally hits mainline it would go in as a nice sequence of logical patches,
> > followed by a random thing which is splattered all over all the preceding
> > patches.
> 
> Does this argue for a respin of the original patches, folding in
> content from this one, rather than splitting it into an additional six to
> be appended to the series?

If the fixes are one-patch-per-concept, and if the original patch series is
one-patch-per-concept (it is) then I can usually insert the fixups in the
right place, later fold each into its appropriate base patch and everything
lands in git squeaky-clean.

