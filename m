Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265672AbUEZNsu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265672AbUEZNsu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 09:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265700AbUEZNsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 09:48:50 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20132 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265672AbUEZNsq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 09:48:46 -0400
Date: Wed, 26 May 2004 14:48:44 +0100
From: Matthew Wilcox <willy@debian.org>
To: "Durairaj, Sundarapandian" <sundarapandian.durairaj@intel.com>
Cc: Andi Kleen <ak@muc.de>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       marcelo.tosatti@cyclades.com,
       "Carbonari, Steven" <steven.carbonari@intel.com>,
       "Seshadri, Harinarayanan" <harinarayanan.seshadri@intel.com>
Subject: Re: [BK PATCH] PCI Express patches for 2.4.27-pre3
Message-ID: <20040526134844.GR29154@parcelfarce.linux.theplanet.co.uk>
References: <6B09584CC3D2124DB45C3B592414FA83021EB9E5@bgsmsx402.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6B09584CC3D2124DB45C3B592414FA83021EB9E5@bgsmsx402.gar.corp.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2004 at 11:59:43AM +0530, Durairaj, Sundarapandian wrote:
> I think its important that we have this patch for 2.4 kernel as well, as
> it will enable the PCI express devices to access extended config space
> (above 256 bytes), where all Advance feature of PCI Express config
> registers resides.

That's not a good reason to add it to 2.4.  If people want access to
that advanced stuff, they can upgrade to 2.6.

By the way, are you working on using any of these advanced features yet?
I'm waiting until I actually have some hardware in my hands before I
do anything.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
