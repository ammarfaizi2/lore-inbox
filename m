Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261411AbVCLD72@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbVCLD72 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 22:59:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261852AbVCLD71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 22:59:27 -0500
Received: from mx1.redhat.com ([66.187.233.31]:58274 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261411AbVCLD7Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 22:59:24 -0500
Date: Fri, 11 Mar 2005 22:58:09 -0500
From: Dave Jones <davej@redhat.com>
To: Mike Werner <werner@sgi.com>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul Mackerras <paulus@samba.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: AGP bogosities
Message-ID: <20050312035809.GB8654@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Mike Werner <werner@sgi.com>, Jesse Barnes <jbarnes@engr.sgi.com>,
	Bjorn Helgaas <bjorn.helgaas@hp.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
References: <16944.62310.967444.786526@cargo.ozlabs.ibm.com> <1110563965.4822.22.camel@eeyore> <200503111004.31311.jbarnes@engr.sgi.com> <200503111927.04807.werner@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503111927.04807.werner@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2005 at 07:27:04PM -0800, Mike Werner wrote:
 > On Friday 11 March 2005 10:04, Jesse Barnes wrote:
 > > On Friday, March 11, 2005 9:59 am, Bjorn Helgaas wrote:
 > > > > Right, it's a special agp driver, sgi-agp.c.
 > > >
 > > > Where's sgi-agp.c?  The HP (ia64-only at the moment) code is hp-agp.c.
 > > > It does make a fake PCI dev for the bridge because DRM still seemed to
 > > > want that.
 > > 
 > > I think Mike posted it but hasn't submitted it to Dave yet since it needed 
 > > another change that only just made it into the ia64 tree.
 > > 
 > > Jesse
 > > 
 > Hi,
 > sgi-agp.c was sent to Dave about 2 weeks ago. I assumed he was waiting for the TIO header
 > files to make it from the ia64 tree into Linus's tree.

Actually I just got swamped with other stuff, and dropped the ball.
I still have the patch in my queue though, so I can push that along.

Are those headers in mainline yet ?

		Dave

