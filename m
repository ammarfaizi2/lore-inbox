Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267180AbUBRC2i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 21:28:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267179AbUBRC2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 21:28:38 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11483 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267172AbUBRC2g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 21:28:36 -0500
Date: Wed, 18 Feb 2004 02:28:31 +0000
From: Matthew Wilcox <willy@debian.org>
To: davidm@hpl.hp.com
Cc: Matthew Wilcox <willy@debian.org>, torvalds@osdl.org,
       Michel D?nzer <michel@daenzer.net>, Anton Blanchard <anton@samba.org>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: radeon warning on 64-bit platforms
Message-ID: <20040218022831.GI11824@parcelfarce.linux.theplanet.co.uk>
References: <1077054385.2714.72.camel@thor.asgaard.local> <16434.36137.623311.751484@napali.hpl.hp.com> <1077055209.2712.80.camel@thor.asgaard.local> <16434.37025.840577.826949@napali.hpl.hp.com> <1077058106.2713.88.camel@thor.asgaard.local> <16434.41884.249541.156083@napali.hpl.hp.com> <20040217234848.GB22534@krispykreme> <16434.46860.429861.157242@napali.hpl.hp.com> <20040218015423.GH11824@parcelfarce.linux.theplanet.co.uk> <16434.50928.682219.187846@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16434.50928.682219.187846@napali.hpl.hp.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 17, 2004 at 05:59:12PM -0800, David Mosberger wrote:
> I personally would be more than happy to reformat things to 80 cols,
> but it's a waste of time unless almost all Linux code gets
> reformatted.

Hm?  I don't know where you're getting that from.  Let's talk numbers.

Of the 60525 lines in .c files in arch/i386, 460 are longer than 80 cols.
Of the 67398 lines in .c files in arch/ia64, 1189 are longer than 80 cols.
Of the 496510 lines in .c files in drivers/net, 4044 are longer than 80 cols.

So arch/i386 has 0.76% > 80 column lines, drivers/net is 0.81% and
arch/ia64 is 1.76%.  Seems fairly convincing to me that ia64 is out of
step with the rest of Linux.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
