Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265658AbTFNJOR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 05:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265659AbTFNJOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 05:14:17 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:56458 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S265658AbTFNJOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 05:14:17 -0400
Date: Sat, 14 Jun 2003 10:28:05 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: EFS breakage in 2.5
Message-ID: <20030614092805.GC18188@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
References: <20030614091014.GA18188@suse.de> <20030614022108.6b9d0e8b.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030614022108.6b9d0e8b.akpm@digeo.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 14, 2003 at 02:21:08AM -0700, Andrew Morton wrote:
 > Dave Jones <davej@codemonkey.org.uk> wrote:
 > >
 > > Current bk oopses during initialisation of EFS.
 > 
 > -					     0, SLAB_HWCACHE_ALIGN||SLAB_RECLAIM_ACCOUNT,
 > +					     0, SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT,

Deja-vu. dee-dee-dee-dee...
That's got to be a cut-n-paste error from the same error that was
fixed a week or so back somewhere else. Hopefully it's the last.

		Dave

