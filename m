Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261158AbVCML4Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbVCML4Z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 06:56:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261164AbVCML4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 06:56:25 -0500
Received: from aun.it.uu.se ([130.238.12.36]:26355 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261158AbVCML4X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 06:56:23 -0500
Date: Sun, 13 Mar 2005 12:56:11 +0100 (MET)
Message-Id: <200503131156.j2DBuBFv015778@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: Re: [PATCH][2.6.11-mm3] perfctr ia32 syscalls on x86-64 fix
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Mar 2005 21:55:49 -0800, Andrew Morton wrote:
>It would be nice to start folding these patches together a bit to reduce
>such problems, but that's rather non-trivial because there is no way to
>simply join these patches together which maintains a sensible sequencing.
>
>If we're going to do anything then it's either a major refactoring, or
>simply wham the entire feature into a single diff.  That diff could then be
>split into four patches: core, ppc, x86 and x86_64.  We would lose the
>layering between ye olde perfctr, the inheritance implementation, the syfs
>API, etc.  I could live with that.
>
>What do you think?

At my end there is already just "the current version"
(with history in cvs) so merging is fine with me.

/Mikael
