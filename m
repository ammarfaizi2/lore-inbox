Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269144AbUJEPaZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269144AbUJEPaZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 11:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269150AbUJEPaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 11:30:25 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57581 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269144AbUJEPaG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 11:30:06 -0400
Date: Tue, 5 Oct 2004 16:29:59 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matthew Wilcox <matthew@wil.cx>, Greg KH <greg@kroah.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@zip.com.au>,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       parisc-linux@parisc-linux.org
Subject: Re: [PATCH] Sort generic PCI fixups after specific ones
Message-ID: <20041005152959.GX16153@parcelfarce.linux.theplanet.co.uk>
References: <20040922214304.GS16153@parcelfarce.linux.theplanet.co.uk> <20040923172038.GA8812@kroah.com> <20040923173151.GX16153@parcelfarce.linux.theplanet.co.uk> <20040924023357.A2526@jurassic.park.msu.ru> <20040930174155.GT16153@parcelfarce.linux.theplanet.co.uk> <20041002014817.A24292@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041002014817.A24292@jurassic.park.msu.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 02, 2004 at 01:48:17AM +0400, Ivan Kokshaysky wrote:
> On Thu, Sep 30, 2004 at 06:41:55PM +0100, Matthew Wilcox wrote:
> > Allow prioritising PCI fixups.  "How it works" is covered in the comment
> > in pci.h.  The patch to superio.c may well only apply with fuzz to the
> > current Linux tree; I include it only to show an example.
> 
> No, you missed my point.
> What we need is yet another PCI fixup *pass*, not prioritizing fixups
> inside *one* pass - see appended patch (compile tested only).

Boot tested.  Works fine for my problem child.  Greg, can you apply
Ivan's patch, please?

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
