Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265167AbTLFNgl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 08:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265168AbTLFNgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 08:36:41 -0500
Received: from mail3.ithnet.com ([217.64.64.7]:31715 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S265167AbTLFNgi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 08:36:38 -0500
X-Sender-Authentication: net64
Date: Sat, 6 Dec 2003 14:36:36 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: ian.soboroff@nist.gov, linux-kernel@vger.kernel.org
Subject: Re: 2.4.23 includes Andrea's VM?
Message-Id: <20031206143636.4f22800d.skraw@ithnet.com>
In-Reply-To: <20031203183719.GD24651@dualathlon.random>
References: <9cfptf6vts7.fsf@rogue.ncsl.nist.gov>
	<20031203183719.GD24651@dualathlon.random>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Dec 2003 19:37:19 +0100
Andrea Arcangeli <andrea@suse.de> wrote:

> On Wed, Dec 03, 2003 at 09:51:36AM -0500, Ian Soboroff wrote:
> > 
> > I have a machine with 12GB of RAM, and I've been running a 2.4.22-era
> > kernel with Andrea's patches on it, otherwise it dies from lack of
> > lowmem.  
> > 
> > The latest -aa patch is for 2.4.23-pre6, but I see in the 2.4.23
> > Changelog that at least some bits of Andrea's VM were merged.  Should
> > I be able to run a vanilla 2.4.23 on this box?
> 
> It's probably going to work an order of magnitude better thanks
> especially to the lower_zone_reserve algorithm.
> 
> However I'd still recommend to use my tree, the last two critical bits
> you need from my tree are inode-highmem and related_bhs. Those two are
> still missing, and you probably need them with 12G.
> 
> I'm going to release a 2.4.23aa1 btw, that will be the last 2.4-aa.

Let us try these please and have them (at last) included in mainline. Thanks
for your continous work.

Regards,
Stephan
