Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261898AbVHFIry@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261898AbVHFIry (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 04:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261979AbVHFIry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 04:47:54 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53485 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261898AbVHFIrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 04:47:41 -0400
Date: Sat, 6 Aug 2005 09:50:13 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Greg KH <greg@kroah.com>, Kristen Accardi <kristen.c.accardi@intel.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       rajesh.shah@intel.com, akpm@osdl.org, torvalds@osdl.org
Subject: Re: [PATCH] 6700/6702PXH quirk
Message-ID: <20050806085013.GA17747@parcelfarce.linux.theplanet.co.uk>
References: <1123259263.8917.9.camel@whizzy> <20050805183505.GA32405@kroah.com> <1123279513.4706.7.camel@whizzy> <20050805225712.GD3782@kroah.com> <20050806033455.GA23679@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050806033455.GA23679@havoc.gtf.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2005 at 11:34:55PM -0400, Jeff Garzik wrote:
> FWIW, compilers generate AWFUL code for bitfields.  Bitfields are
> really tough to do optimally, whereas bit flags ["unsigned int flags &
> bitmask"] are the familiar ints and longs that the compiler is well
> tuned to optimize.

I'm sure the GCC developers would appreciate a good bug report with a
test-case that generates worse code.  If you don't want to mess with their
bug tracking system, just send me a test case and I'll add it for you.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
