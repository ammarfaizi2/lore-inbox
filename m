Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265093AbUG2Tsq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265093AbUG2Tsq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 15:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265086AbUG2Tsp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 15:48:45 -0400
Received: from hera.cwi.nl ([192.16.191.8]:1447 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S265093AbUG2Tsb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 15:48:31 -0400
Date: Thu, 29 Jul 2004 21:48:03 +0200
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: James Morris <jmorris@redhat.com>
Cc: Andries Brouwer <aebr@win.tue.nl>, Andrew Morton <akpm@osdl.org>,
       dpf-lkml@fountainbay.com, linux-kernel@vger.kernel.org,
       Andries.Brouwer@cwi.nl
Subject: Re: [PATCH] Delete cryptoloop
Message-ID: <20040729194803.GC5413@apps.cwi.nl>
References: <20040729161203.GB4008@pclin040.win.tue.nl> <Xine.LNX.4.44.0407291320580.16390-100000@dhcp83-76.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Xine.LNX.4.44.0407291320580.16390-100000@dhcp83-76.boston.redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2004 at 01:23:35PM -0400, James Morris wrote:
> On Thu, 29 Jul 2004, Andries Brouwer wrote:
> 
> > # Part of the reason for dropping cryptoloop is to help dm-crypt
> > # mature more quickly.
> > 
> > A very strange reason. But maybe it fits in with dropping the idea
> > of a stable kernel.
> 
> Well, now that the kernel development model has changed (there may not be
> a 2.7 in the forseeable future), just when do you drop buggy, unmaintained
> code?

Most of the kernel is buggy.
Most of the kernel is unmaintained.

Drop code when it has become superfluous - the same functionality
is provided by other parts, less buggy, or better maintained, or
with other redeeming features. (But very slowly - try to preserve
kernel interface stability for several years.)

Drop code when it has become superfluous - the functionality is
not needed any more.

Drop code when it is broken - some change somewhere broke it,
and no kernel developer has the knowledge, or desire, or time,
to fix it.

Drop code when it has become a burden - when the need to keep it working
causes complications al over the place.


Andries
