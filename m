Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266294AbUFUPmY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266294AbUFUPmY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 11:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266284AbUFUPmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 11:42:24 -0400
Received: from gate.crashing.org ([63.228.1.57]:15007 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266283AbUFUPlu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 11:41:50 -0400
Subject: Re: [Patch]: Fix rivafb's NV_ARCH_
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Guido Guenther <agx@sigxcpu.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040621071159.GA7017@bogon.ms20.nix>
References: <20040601041604.GA2344@bogon.ms20.nix>
	 <1086064086.1978.0.camel@gaston> <20040601135335.GA5406@bogon.ms20.nix>
	 <20040616070326.GE28487@bogon.ms20.nix>
	 <20040620192549.GA4307@bogon.ms20.nix> <1087791100.24157.9.camel@gaston>
	 <20040621071159.GA7017@bogon.ms20.nix>
Content-Type: text/plain
Message-Id: <1087832204.22683.11.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 21 Jun 2004 10:36:44 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-06-21 at 02:11, Guido Guenther wrote:
> On Sun, Jun 20, 2004 at 11:11:41PM -0500, Benjamin Herrenschmidt wrote:
> > On Sun, 2004-06-20 at 14:25, Guido Guenther wrote:
> > > Hi,
> > > On Wed, Jun 16, 2004 at 09:03:27AM +0200, Guido Guenther wrote:
> > > > here's another piece of rivafb fixing that helps the driver on ppc
> > > > pbooks again a bit further. It corrects several wrong NV_ARCH_20
> > > > settings which are actually NV_ARCH_10 as determined by the PCIId.
> > > Any comments on this patch?
> > 
> > I don't, but did you ask on the linux-fbdev list ?
> I've sent a patch to James several weeks ago that removes the complete
> table with NV_ARCH_ mappings and uses PCI-IDs instead. He applied it to
> the fbdev tree, but it didn't end up in Linus tree yet.
> This patch just fixes what's obviously wrong. More cleanup to come once
> rivafb is in a usable shape for me again.

Ok, well, it looks good to me. There is no active maintainer for rivafb
so, I suppose if nobody complains of breakage, it should be fine.

Ben.


