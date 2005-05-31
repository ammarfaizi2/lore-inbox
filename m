Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261490AbVEaVZg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261490AbVEaVZg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 17:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbVEaVZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 17:25:36 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58568 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261490AbVEaVZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 17:25:13 -0400
Date: Tue, 31 May 2005 22:25:45 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Greg KH <gregkh@suse.de>, stable@kernel.org, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH] pci-sysfs: backport fix for 2.6.11.12
Message-ID: <20050531212545.GS14929@parcelfarce.linux.theplanet.co.uk>
References: <20050531163619.GA6711@mellanox.co.il> <20050531192349.GA21050@suse.de> <20050531205729.GA7921@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050531205729.GA7921@mellanox.co.il>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2005 at 11:57:29PM +0300, Michael S. Tsirkin wrote:
> No, unsigned int is 32 bit wide on all platforms with gcc,
> char is signed and 8 bit wide on all platforms with gcc.

Oops, no.  char is signed on x86 and unsigned on ppc.  Other architectures
vary (I believe arm, mips and parisc are also unsigned).

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
