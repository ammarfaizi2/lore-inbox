Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264327AbTDXAlu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 20:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264337AbTDXAlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 20:41:50 -0400
Received: from nessie.weebeastie.net ([61.8.7.205]:3460 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id S264327AbTDXAlt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 20:41:49 -0400
Date: Thu, 24 Apr 2003 10:54:36 +1000
From: CaT <cat@zip.com.au>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fix SWSUSP & !SWAP
Message-ID: <20030424005436.GF678@zip.com.au>
References: <1051136725.4439.5.camel@laptop-linux> <1584040000.1051140524@flay> <20030423235820.GB32577@atrey.karlin.mff.cuni.cz> <20030423170759.2b4e6294.akpm@digeo.com> <20030424001733.GB678@zip.com.au> <1051143408.4305.15.camel@laptop-linux> <20030423172628.0f71ab64.rddunlap@osdl.org> <20030423173837.08202f0b.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030423173837.08202f0b.akpm@digeo.com>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 23, 2003 at 05:38:37PM -0700, Andrew Morton wrote:
> "Randy.Dunlap" <rddunlap@osdl.org> wrote:
> >
> > That may be simple for you, but for lots of users, adding a partition
> > (to a ususally full disk drive) isn't simple.  It means backups,
> > shrink a filesystem, shrink a partition, add a partition, and run
> > mkswap on it.   Yes, the latter 2 are simple, but the former ones
> > are not.
> 
> Yeah.  swsusp is pretty much the only reason why you would want to have a
> swap partition at all in a 2.5/2.6 kernel.

Is there really no difference any longer in terms of speed?

-- 
Martin's distress was in contrast to the bitter satisfaction of some
of his fellow marines as they surveyed the scene. "The Iraqis are sick
people and we are the chemotherapy," said Corporal Ryan Dupre. "I am
starting to hate this country. Wait till I get hold of a friggin' Iraqi.
No, I won't get hold of one. I'll just kill him."
	- http://www.informationclearinghouse.info/article2479.htm
