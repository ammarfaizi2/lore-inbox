Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264511AbTLVVSd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 16:18:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264518AbTLVVSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 16:18:33 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:47532 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP id S264511AbTLVVSb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 16:18:31 -0500
Date: Mon, 22 Dec 2003 23:18:17 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: lot of VM problem with 2.4.23
Message-ID: <20031222211817.GM1455@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	Andrea Arcangeli <andrea@suse.de>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	linux-kernel@vger.kernel.org
References: <20031221150312.GJ25043@ovh.net> <20031221154227.GB1323@alpha.home.local> <20031221161324.GN25043@ovh.net> <Pine.LNX.4.58L.0312211643470.6632@logos.cnet> <20031221191431.GP25043@ovh.net> <Pine.LNX.4.58L.0312211832320.6632@logos.cnet> <20031221210917.GB4897@ovh.net> <20031221222338.GC1323@alpha.home.local> <20031222070344.GL1524@niksula.cs.hut.fi> <20031222190943.GF18767@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031222190943.GF18767@dualathlon.random>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 22, 2003 at 08:09:43PM +0100, you [Andrea Arcangeli] wrote:
> On Mon, Dec 22, 2003 at 09:03:44AM +0200, Ville Herva wrote:
> > 
> > BTW, I have a box with 128MB ram and 512MB swap running 2.4.21-jam1 (it has
> > the -aa vm). I can't shut it down cleanly, because trying it goes into
> > endless loop trying to free memory when turning off swap. Nothing but
> > alt-sysrq-b seems to work.
> > 
> > I don't know if there is a kernel memory leak, since all user level
> > processes should be killed at that point, right? Unfortunately I didn't have
> > time to dig deeper, as the box is in (sort of) production.
> 
> if this is a leak, I doubt it has been introduced recently, the only
> swap accounting related change was in the shm layer, and it was supposed
> to be a race fix. You may want to check if you've some shm allocated
> in /dev/shm or ipcs, while the machine reboots.

I'll check that the next time I reboot. 

Unfortunately the box is in (semi-)production so I can't reboot it at will.

 
-- v --

v@iki.fi
