Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262489AbVAPMKM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262489AbVAPMKM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 07:10:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262491AbVAPMKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 07:10:12 -0500
Received: from hermine.aitel.hist.no ([158.38.50.15]:61963 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S262489AbVAPMKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 07:10:04 -0500
Date: Sun, 16 Jan 2005 13:18:23 +0100
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Helge Hafting <helgehaf@aitel.hist.no>, Dave Airlie <airlied@gmail.com>,
       covici@ccs.covici.com,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.10 dies when X tries to initialize PCI radeon 9200 SE
Message-ID: <20050116121823.GA7734@hh.idb.hist.no>
References: <41E64DAB.1010808@hist.no> <16870.21720.866418.326325@ccs.covici.com> <21d7e997050113130659da39c9@mail.gmail.com> <20050115185712.GA17372@hh.idb.hist.no> <21d7e997050116020859687c4a@mail.gmail.com> <20050116105011.GA5882@hh.idb.hist.no> <9e4733910501160304642f7882@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e4733910501160304642f7882@mail.gmail.com>
User-Agent: Mutt/1.5.6+20040907i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 16, 2005 at 06:04:32AM -0500, Jon Smirl wrote:
> you need to check the output from "modprobe drm debug=1" "modprobe
> radeon" and see if drm is misidentifying the board as AGP. We don't
> want to fix something if it isn't broken.
> 
Stupid question - how do I get a modular drm?
I usually make everything compiled-in with no module support.
But now I made a kernel with module support and selected "M"
for the agp stuff and for the radeon and matrox DRM support.
But DRM itself will only accept Yes or No, Module is not an
option there with "make menuconfig".  So I can load
and unload the radeon module now, but there is no DRM module.
loading/unloading radeon gives me messages from DRM about this
happening, but DRM itself is compiled in so I can't modprobe it
with that debug parameter.

Is there perhaps something in some other menu that needs to be (M)
before (M) becomes an option for DRM?

Helge Hafting

