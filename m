Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261377AbVC0Ap4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261377AbVC0Ap4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 19:45:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261382AbVC0Ap4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 19:45:56 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61676 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261377AbVC0Apu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 19:45:50 -0500
Date: Sun, 27 Mar 2005 00:45:49 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: Matthew Wilcox <matthew@wil.cx>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [ARM] Group device drivers together under their own menu
Message-ID: <20050327004549.GS21986@parcelfarce.linux.theplanet.co.uk>
References: <200503261912.j2QJC192031517@hera.kernel.org> <20050326214141.GR21986@parcelfarce.linux.theplanet.co.uk> <20050326225026.D23306@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050326225026.D23306@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 26, 2005 at 10:50:26PM +0000, Russell King wrote:
> On Sat, Mar 26, 2005 at 09:41:41PM +0000, Matthew Wilcox wrote:
> > Any reason you can't merge ARM's options into the drivers/*/Kconfig (with
> > appropriate conditionals) and use drivers/Kconfig?
> 
> Dunno.  Haven't gotten around to sorting that out yet, and I don't
> particularly fancy trying to fight any corners over it.
> 
> I think, a while back, it was thought to be better to keep ARM separate
> to keep the conditionals out of drivers/Kconfig.
> 
> If the general concensus has changed, I might eventually sort it out if
> it causes enough trouble, or people think there's sufficient value to it.

As the original author of drivers/Kconfig, I think it's a brilliant
idea that everybody should use ;-)  I haven't heard any dissenting
opinions yet.  The only complaint I've heard is that net/Kconfig is now
under device drivers.  I didn't make that change, and I agree it sucks.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
