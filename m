Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266533AbUF0BJE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266533AbUF0BJE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 21:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266536AbUF0BJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 21:09:04 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30378 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266533AbUF0BJA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 21:09:00 -0400
Date: Sun, 27 Jun 2004 02:08:59 +0100
From: Matthew Wilcox <willy@debian.org>
To: Roland Dreier <roland@topspin.com>
Cc: Matthew Wilcox <willy@debian.org>, mj@ucw.cz,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pciutils: Support for MSI-X capability
Message-ID: <20040627010859.GB30334@parcelfarce.linux.theplanet.co.uk>
References: <52y8mayzdy.fsf@topspin.com> <20040626215421.GA26262@parcelfarce.linux.theplanet.co.uk> <52r7s1zyn1.fsf@topspin.com> <20040627005455.GA30334@parcelfarce.linux.theplanet.co.uk> <52n02pzude.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52n02pzude.fsf@topspin.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 26, 2004 at 06:01:49PM -0700, Roland Dreier wrote:
>     Matthew> Did you not see the one I posted to linux-pci yesterday?
>     Matthew> As I say, it's only half-done.  I wanted to get a feel
>     Matthew> for whether people like the direction I'm taking.
> 
>     Matthew> Unfortunately, I can't see a web archive of linux-pci
>     Matthew> anywhere -- even on MArc.  I can forward the patches
>     Matthew> though.
> 
> Sorry, I'm not subscribed to linux-pci, so I missed them.
> 
> I would be interested in taking a look at your patches.  Are you
> handling the full 4K extended config space, or just the PCI-e
> capability in the standard config space?

OK.  I'll send them to you privately as replies to this mail.

The first patch (which needs a little tightening up) adds support for
accessing and printing all 4k of configuration space with the -xxx option.

The second patch (incomplete) adds support for the Express capability.
There's some stuff it doesn't decode yet.  I'll be updating this patch
on Monday, I expect.

The third patch (even more incomplete) adds infrastructure for walking
and decoding extended capabilities.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
