Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030347AbWFISXE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030347AbWFISXE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 14:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030343AbWFISXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 14:23:04 -0400
Received: from 24-75-174-210-st.chvlva.adelphia.net ([24.75.174.210]:40641
	"EHLO sanosuke.troilus.org") by vger.kernel.org with ESMTP
	id S1030341AbWFISXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 14:23:01 -0400
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       cmm@us.ibm.com, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 0/13] extents and 48bit ext3
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
	<20060609091327.GA3679@infradead.org>
	<20060609030759.48cd17a0.akpm@osdl.org> <44899653.1020007@garzik.org>
From: Michael Poole <mdpoole@troilus.org>
Date: 09 Jun 2006 14:23:00 -0400
In-Reply-To: <44899653.1020007@garzik.org>
Message-ID: <87irnab33v.fsf@graviton.dyn.troilus.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik writes:

> Andrew Morton wrote:
> > Ted&co have been pretty good at avoiding compatibility problems.
> 
> Well, extents and 48bit make that track record demonstrably worse.
> 
> Users are now forced to remember that, if they write to their
> filesystem after using either $mmver or $korgver kernels, they are
> locked out of using older kernels.

Users are also forced to remember that, if they use certain new
distros or programs, they are locked out of using older kernels.  They
are forced to remember that if they have certain newer hardware, they
are locked out of using older kernels.  They are forced to remember
that if they use ext3 (or XFS or JFS) _at all_ they are locked out of
using older kernels.  Why single out this particular aspect of limited
forward compatibility to harp on so much?

Michael Poole
