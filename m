Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264389AbTICXL3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 19:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264406AbTICXL2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 19:11:28 -0400
Received: from mail0-96.ewetel.de ([212.6.122.96]:33701 "EHLO mail0.ewetel.de")
	by vger.kernel.org with ESMTP id S264389AbTICXLV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 19:11:21 -0400
Date: Thu, 4 Sep 2003 01:11:15 +0200 (CEST)
From: Pascal Schmidt <der.eremit@email.de>
To: David Schwartz <davids@webmaster.com>
cc: linux-kernel@vger.kernel.org
Subject: RE: Driver Model
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKMEMAGDAA.davids@webmaster.com>
Message-ID: <Pine.LNX.4.44.0309040049490.5139-100000@neptune.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Sep 2003, David Schwartz wrote:

> If the GPL_ONLY stuff is a license enforcement scheme, the DMCA 
> prohibits you from removing it.

-ENOTUSCITIZEN

> If the GPL_ONLY stuff is not a license enforcement scheme, nothing 
> prohibits you from stamping your module GPL when it's not.

I'd say its up to the lawyers and judges to find out whether having
MODULE_LICENSE("GPL") in a module means anything legally. It might
mean "I promise this module is made from GPL source", but it might
also mean nothing.

> However, the GPL (section 2b) prohibits you from imposing any
> restrictions other than those in the GPL itself.

Section 2b) in the file COPYING in the root dir of the kernel source
does not talk about restrictions. Are we talking about the same version
of the GPL?

> The GPL contains no restrictions that
> apply to mere use and the GPL_ONLY stuff affects use, so it can't be a
> license restriction, hence there is no restriction to enforce.

The GPL doesn't even cover use of the "product". It covers modification
and redistribution.

Well, it is still an open question whether kernel modules are derived
works or not, especially since we don't have a stable kernel ABI and
therefore modules have to use part of the kernel source (headers) and
module writers have to study kernel code to write their modules (since
there is no official complete documentation about functions in the 
kernel).

If modules are derived works, then legally, following the GPL, they
must be GPL too and GPL_ONLY is no problem but pointless.

Seems to me you could say GPL_ONLY is a way of the developer saying
"I consider your stuff to be a derived work if you use this symbol".
Ask a lawyer whether that's their decision to make. ;)

Apart from that, I fail to see how it is an addition restriction
when you still have the right to remove all the GPL_ONLY stuff. After
all, the kernel is GPLed work, so you have the right to remove
things and distribute the result. How is it a real restriction when
the license allows you to remove it?

-- 
Ciao,
Pascal

