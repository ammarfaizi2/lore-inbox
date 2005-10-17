Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751434AbVJRBVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434AbVJRBVk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 21:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751436AbVJRBVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 21:21:40 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:32215
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1751434AbVJRBVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 21:21:40 -0400
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Felix Oxley <lkml@oxley.org>
Subject: Re: [PATCH 1/1] Kconfig help text for RAM Disk & initrd
Date: Mon, 17 Oct 2005 16:32:02 -0500
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <200510170102.19717.lkml@oxley.org> <200510170233.46811.rob@landley.net> <200510171344.18416.lkml@oxley.org>
In-Reply-To: <200510171344.18416.lkml@oxley.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510171632.02436.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 17 October 2005 07:44, Felix Oxley wrote:
> On Monday 17 October 2005 08:33, Rob Landley wrote:
> > > On Monday 17 October 2005 06:37, Rob Landley wrote:
> > > > Actually if this is a patch against 2.6, between ramfs (including
> > > > initramfs) and the ability to loopback mount files, I personally
> > > > consider ramdisks semi-obsolete.  (This might be _why_ it says most
> > > > normal users won't need them.)
>
> You are right in all you say.
> However, my system uses initrd and I thought that a help message warning
> newbies that these options are required if inrd is used, would be useful.
> Since I removed it and was uanble to boot :-)

Understandable concern.

> Do you think the slimmed down patch below is appropriate, or shall I just
> drop the subject?

Well, it's better.  The first part's a clear correction.

When you note that some systems need it to build, I'd mention that newer 
systems should probably be using initramfs.  Other than that, no objection.

Rob
