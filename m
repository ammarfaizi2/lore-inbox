Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262635AbVAPWQs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262635AbVAPWQs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 17:16:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262633AbVAPWQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 17:16:47 -0500
Received: from hermine.aitel.hist.no ([158.38.50.15]:49937 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S262635AbVAPWQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 17:16:08 -0500
Date: Sun, 16 Jan 2005 23:24:28 +0100
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Dave Airlie <airlied@gmail.com>, covici@ccs.covici.com,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.10 dies when X tries to initialize PCI radeon 9200 SE
Message-ID: <20050116222428.GA20189@hh.idb.hist.no>
References: <41E64DAB.1010808@hist.no> <16870.21720.866418.326325@ccs.covici.com> <21d7e997050113130659da39c9@mail.gmail.com> <20050115185712.GA17372@hh.idb.hist.no> <21d7e997050116020859687c4a@mail.gmail.com> <20050116105011.GA5882@hh.idb.hist.no> <9e4733910501160304642f7882@mail.gmail.com> <20050116121823.GA7734@hh.idb.hist.no> <9e4733910501161408710bbbe2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e4733910501161408710bbbe2@mail.gmail.com>
User-Agent: Mutt/1.5.6+20040907i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 16, 2005 at 05:08:12PM -0500, Jon Smirl wrote:
> On Sun, 16 Jan 2005 13:18:23 +0100, Helge Hafting
> <helgehaf@aitel.hist.no> wrote:
> > On Sun, Jan 16, 2005 at 06:04:32AM -0500, Jon Smirl wrote:
> > > you need to check the output from "modprobe drm debug=1" "modprobe
> > > radeon" and see if drm is misidentifying the board as AGP. We don't
> > > want to fix something if it isn't broken.
> > > 
> > Stupid question - how do I get a modular drm?
> 
> For older radeon drivers "modprobe radeon debug=1" should work. I also
> think you can do it for compiled in ones by adding the kernel
> parameter radeon.debug=1

I tried that - and got a message from the radeon module that "debug" 
was an unknown parameter.

Helge Hafting
