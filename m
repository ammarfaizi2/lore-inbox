Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266457AbUFZVyX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266457AbUFZVyX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 17:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266458AbUFZVyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 17:54:23 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33445 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266457AbUFZVyW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 17:54:22 -0400
Date: Sat, 26 Jun 2004 22:54:21 +0100
From: Matthew Wilcox <willy@debian.org>
To: Roland Dreier <roland@topspin.com>
Cc: mj@ucw.cz, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pciutils: Support for MSI-X capability
Message-ID: <20040626215421.GA26262@parcelfarce.linux.theplanet.co.uk>
References: <52y8mayzdy.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52y8mayzdy.fsf@topspin.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 26, 2004 at 10:58:49AM -0700, Roland Dreier wrote:
> Hi, here is a patch to pciutils that adds parsing of MSI-X capability
> entries.  With this patch, an MSI-X capability will be dumped with -v as

Thanks for doing this, Roland.  I was going to get to it in a few days.
Unfortunately, it's going to conflict in a few textual ways with one or
two of the [RFC] patches I posted.

Martin, how can we make this easiest for you?  Do you want to merge
Roland's fully-fledged MSI-X patch and put out a new -test release that
I can send half-baked PCI-E patches against until everybody's happy with
the outcome?

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
