Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265356AbSKFOSL>; Wed, 6 Nov 2002 09:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265365AbSKFOSL>; Wed, 6 Nov 2002 09:18:11 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:61353 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S265356AbSKFOSK>;
	Wed, 6 Nov 2002 09:18:10 -0500
Date: Wed, 6 Nov 2002 15:24:21 +0100
From: Jens Axboe <axboe@suse.de>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Lars Marowsky-Bree <lmb@suse.de>,
       Kevin Corry <corryk@us.ibm.com>, evms-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Evms-announce] EVMS announcement
Message-ID: <20021106142421.GD839@suse.de>
References: <02110516191004.07074@boiler> <20021106001607.GJ27832@marowsky-bree.de> <1036590957.9803.24.camel@irongate.swansea.linux.org.uk> <1036591157.2509.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1036591157.2509.3.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06 2002, Arjan van de Ven wrote:
> On Wed, 2002-11-06 at 14:55, Alan Cox wrote:
> > On Wed, 2002-11-06 at 00:16, Lars Marowsky-Bree wrote:
> > > Now, an interesting question is whether the md modules etc will simply be
> > > continued to be used or whether they'll make use of the DM engine too? Can
> > > they be made "plugins" to DM or the EVMS framework? Or even, could EVMS (in
> > > theory) parse the meta-data from a legacy md device and just setup a DM
> > > mapping for it? That would appeal to me quite a bit. I really need to start
> > > reading up on it...
> > 
> > I'm certainly hoping to kill off ataraid/pdcraid/hptraid by using device
> > mapper and md
> 
> absolutely. The biggest issue with this is that DM needs to be able to

Especially because the code is so ugly :-)

> handle chunks where 1 page is split across 2 strides on disk... if/once
> DM (and BIO) can deal with that the rest isn't hard...

That's a helper that's been on my todo for a long time, so it should be
pending very shortly..

-- 
Jens Axboe

