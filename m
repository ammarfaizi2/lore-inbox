Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262892AbUB0Ou6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 09:50:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262895AbUB0Ou5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 09:50:57 -0500
Received: from pileup.ihatent.com ([217.13.24.22]:32260 "EHLO
	pileup.ihatent.com") by vger.kernel.org with ESMTP id S262892AbUB0Ou4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 09:50:56 -0500
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-mm3 sometimes freeze on "sync"
References: <20040222172200.1d6bdfae.akpm@osdl.org>
	<403C7D4D.1040104@aitel.hist.no>
	<20040225013938.53179d6c.akpm@osdl.org>
	<403DB324.9080702@aitel.hist.no>
From: Alexander Hoogerhuis <alexh@ihatent.com>
Date: 27 Feb 2004 15:49:38 +0100
In-Reply-To: <403DB324.9080702@aitel.hist.no>
Message-ID: <874qtc4lx9.fsf@lapper.ihatent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting <helgehaf@aitel.hist.no> writes:

> Andrew Morton wrote:
> > Helge Hafting <helgehaf@aitel.hist.no> wrote:
> >
> >>2.6.3-mm3 (and 2.6.3-mm1) occationally freeze on "sync".
> > yup. bug.  This should fix.
> 
> This seems to work for me.  I've booted 2.6.3-mm3 with this
> patch.  I ran some syncs, then forced the machine to
> swap with a big tar and ran some more syncs.  It works.
> 

Just posted in reply to someone else ont he list, but I'm runnign -mm3
with the patch and seeing hangs after mkfs'ing ext3 fs'es on HP
servers with the cciss-driver; roughly 50% chance of it happening on
"umount /dir && mke2fs -j -L /dir /dev/cciss/c0d0p5 && mount /dir".

> Helge Hafting
> 

mvh,
A
-- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy
