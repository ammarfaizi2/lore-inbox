Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265617AbUAZXxh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 18:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265592AbUAZXxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 18:53:37 -0500
Received: from cpe-024-033-224-91.neo.rr.com ([24.33.224.91]:41360 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S265635AbUAZXw2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 18:52:28 -0500
Date: Mon, 26 Jan 2004 18:37:38 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: David Sanders <linux@sandersweb.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PNP depends on ISA ? (2.6.2-rc2
Message-ID: <20040126183738.GB3180@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	David Sanders <linux@sandersweb.net>, linux-kernel@vger.kernel.org
References: <20040126193144.GC2004@luna.mooo.com> <20040126161746.GA3180@neo.rr.com> <200401261813.48324@sandersweb.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401261813.48324@sandersweb.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 26, 2004 at 06:15:43PM -0500, David Sanders wrote:
> On Monday 26 January 2004 11:17 am, Adam Belay wrote:
> > On Mon, Jan 26, 2004 at 09:31:44PM +0200, Micha Feigin wrote:
> > > I was wondering why pnp depends on isa being selected in 2.6.2-rc2,
> 
> > Yes, it only is related to isa devices, but they include onboard
> I the 2.4.x kernel I seem to remember being able to cat /proc/isapnp 
> and getting info about pnp devices on my system.  Is there an 
> equivalent in 2.6.x ?

Yes.  A complete interface, including id information and control over
resource management is provided through sysfs.

#mkdir /sys
#mount -t sysfs none /sys

Look in /sys/bus/pnp for more information.

Thanks,
Adam
