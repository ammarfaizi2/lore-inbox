Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750841AbWFTUED@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750841AbWFTUED (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 16:04:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750852AbWFTUED
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 16:04:03 -0400
Received: from mx.pathscale.com ([64.160.42.68]:28373 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1750841AbWFTUEB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 16:04:01 -0400
Date: Tue, 20 Jun 2006 13:03:52 -0700
From: Greg Lindahl <greg.lindahl@qlogic.com>
To: Andi Kleen <ak@suse.de>
Cc: Dave Olson <olson@unixfolk.com>, discuss@x86-64.org,
       Brice Goglin <brice@myri.com>, linux-kernel@vger.kernel.org,
       gregkh@suse.de
Subject: Re: [discuss] Re: [RFC] Whitelist chipsets supporting MSI and check Hyper-transport capabilities
Message-ID: <20060620200352.GJ1414@greglaptop.internal.keyresearch.com>
Mail-Followup-To: Andi Kleen <ak@suse.de>,
	Dave Olson <olson@unixfolk.com>, discuss@x86-64.org,
	Brice Goglin <brice@myri.com>, linux-kernel@vger.kernel.org,
	gregkh@suse.de
References: <fa.5FgZbVFZIyOdjQ3utdNvbqTrUq0@ifi.uio.no> <fa.URgTUhhO9H/aLp98XyIN2gzSppk@ifi.uio.no> <Pine.LNX.4.61.0606192237560.25433@osa.unixfolk.com> <200606200925.30926.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606200925.30926.ak@suse.de>
User-Agent: Mutt/1.4.1i
X-Frumious: Bandersnatch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2006 at 09:25:30AM +0200, Andi Kleen wrote:

> So if there are any more MSI problems comming up IMHO it should be white list/disabled 
> by default and only turn on after a long time when Windows uses it by default 
> or something. Greg, do you agree?

You probably meant the other Greg, but the situation doesn't seem to
be that bad. Brice's proposed whitelist covers almost all Opteron PCI
Express servers.

What is the list of things which are known to have problems? All
PCI-X?  We can ask some more people with PCI-X MSI cards what works
for them, i.e.  Mellanox.

-- greg

