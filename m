Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261631AbVAXUYx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbVAXUYx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 15:24:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261624AbVAXUXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 15:23:09 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10912 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261626AbVAXUWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 15:22:23 -0500
Date: Mon, 24 Jan 2005 20:22:23 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Matthew Wilcox <matthew@wil.cx>, Jesse Barnes <jbarnes@sgi.com>,
       Jeff Garzik <jgarzik@pobox.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Fwd: Patch to control VGA bus routing and active VGA device.
Message-ID: <20050124202223.GO31455@parcelfarce.linux.theplanet.co.uk>
References: <9e47339105011719436a9e5038@mail.gmail.com> <41ED3BD2.1090105@pobox.com> <9e473391050122083822a7f81c@mail.gmail.com> <200501240847.51208.jbarnes@sgi.com> <20050124175131.GM31455@parcelfarce.linux.theplanet.co.uk> <9e473391050124111767a9c6b7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e473391050124111767a9c6b7@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2005 at 02:17:15PM -0500, Jon Smirl wrote:
> On Mon, 24 Jan 2005 17:51:31 +0000, Matthew Wilcox <matthew@wil.cx> wrote:
> > Yes -- *very* platform specific.  Some are even configurable as to how
> > much they support.  See http://ftp.parisc-linux.org/docs/chips/zx1-mio.pdf
> 
> Is this a justification for doing device drivers for bridge chips? It
> has been mentioned before but no one has done it.

I don't think this is ... the bridges mentioned are host->pci bridges.

> Any ideas why the code I sent won't work on the x86? I can shut
> routing off but I can't get it back on again.
> 
> The motivation behind the code is to get X to quit doing this from user space.

I suppose we could log all access X does and compare to what your code
ends up doing ...

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
