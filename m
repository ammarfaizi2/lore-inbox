Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263444AbTDDDA4 (for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 22:00:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263441AbTDDDA4 (for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 22:00:56 -0500
Received: from nessie.weebeastie.net ([61.8.7.205]:7909 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id S263483AbTDDDAr (for <rfc822;linux-kernel@vger.kernel.org>); Thu, 3 Apr 2003 22:00:47 -0500
Date: Fri, 4 Apr 2003 13:14:02 +1000
From: CaT <cat@zip.com.au>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.66-mm3: hang and crash
Message-ID: <20030404031402.GA457@zip.com.au>
References: <20030404013732.GA466@zip.com.au> <20030403183604.6a4cc385.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030403183604.6a4cc385.akpm@digeo.com>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 03, 2003 at 06:36:04PM -0800, Andrew Morton wrote:
> > 2. After I booted, I logged into X, started up my mutts (6 of em) and
> >    started moving the mouse cursor about. Laptop turned itself off.
> 
> The first thing to do when a -mm kernel mysteriously explodes is to try just
> the Linus part.  Could you please do that?

Done.

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.66/2.5.66-mm3/broken-out/linus.patch
> 
> It is against 2.5.66.

I had to apply the framebuffer patch so that my kernel would not crash
for that reason (this was applied to the original mm3 aswell - forgot to
metnion). Also the percentile tmpfs was applied. Normal kernel works
fine with both patches.

Still, the linus.patch produced the same result. If you think it's
worthwhile I'll compile out the fa and perc patchesb but I didn't think
it significant due to them workign just fine with 2.5.66.

-- 
Martin's distress was in contrast to the bitter satisfaction of some
of his fellow marines as they surveyed the scene. "The Iraqis are sick
people and we are the chemotherapy," said Corporal Ryan Dupre. "I am
starting to hate this country. Wait till I get hold of a friggin' Iraqi.
No, I won't get hold of one. I'll just kill him."
	- http://www.informationclearinghouse.info/article2479.htm
