Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261611AbVAXUOc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261611AbVAXUOc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 15:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261615AbVAXUOc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 15:14:32 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33183 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261611AbVAXUOU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 15:14:20 -0500
Date: Mon, 24 Jan 2005 20:14:17 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Jon Smirl <jonsmirl@gmail.com>, Matthew Wilcox <matthew@wil.cx>,
       Jesse Barnes <jbarnes@sgi.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Fwd: Patch to control VGA bus routing and active VGA device.
Message-ID: <20050124201417.GN31455@parcelfarce.linux.theplanet.co.uk>
References: <9e47339105011719436a9e5038@mail.gmail.com> <41ED3BD2.1090105@pobox.com> <9e473391050122083822a7f81c@mail.gmail.com> <200501240847.51208.jbarnes@sgi.com> <20050124175131.GM31455@parcelfarce.linux.theplanet.co.uk> <9e473391050124111767a9c6b7@mail.gmail.com> <41F54FC1.6080207@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41F54FC1.6080207@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2005 at 02:42:57PM -0500, Jeff Garzik wrote:
> Jon Smirl wrote:
> >Is this a justification for doing device drivers for bridge chips? It
> >has been mentioned before but no one has done it.
> 
> Yeah, people are usually slack and work around the problem.
> 
> A bridge driver is really wanted for several situations in today's 
> hardware...

Annoyingly, we already have one, it's just special-cased for PCI Express.
On my todo for this week is to take it out of the pcie directory and fix it.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
