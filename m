Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268019AbUJNXd6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268019AbUJNXd6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 19:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267916AbUJNXa2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 19:30:28 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:58891 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S267783AbUJNX2Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 19:28:24 -0400
Date: Fri, 15 Oct 2004 00:28:22 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: David Woodhouse <dwmw2@infradead.org>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: __attribute__((unused))
In-Reply-To: <20041014230802.C28649@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.58L.0410150025000.25607@blysk.ds.pg.gda.pl>
References: <20041014220243.B28649@flint.arm.linux.org.uk>
 <1097791496.5788.2034.camel@baythorne.infradead.org>
 <20041014230802.C28649@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Oct 2004, Russell King wrote:

> It's the "later compilers" which I'm worried about here - I think they
> defined "unused" to mean "this really really isn't used and you can
> discard it".  Hence my concern with the above.

 Your concern is valid.  Much enough it's been already fixed in 2.4.27, so
I suppose 2.6 deserves the fix, too.

  Maciej
