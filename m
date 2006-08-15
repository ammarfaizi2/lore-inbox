Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750814AbWHOX0Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbWHOX0Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 19:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750813AbWHOX0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 19:26:24 -0400
Received: from mga01.intel.com ([192.55.52.88]:24732 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750786AbWHOX0X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 19:26:23 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,129,1154934000"; 
   d="scan'208"; a="116776184:sNHT12695977490"
Date: Tue, 15 Aug 2006 16:26:06 -0700
From: Mitch Williams <mitch.a.williams@intel.com>
X-X-Sender: mawilli1@mawilli1-desk2.amr.corp.intel.com
To: David Miller <davem@davemloft.net>
cc: shemminger@osdl.org, "Williams, Mitch A" <mitch.a.williams@intel.com>,
       notting@redhat.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: bonding: cannot remove certain named devices
In-Reply-To: <20060815.155612.111203542.davem@davemloft.net>
Message-ID: <Pine.CYG.4.58.0608151623560.508@mawilli1-desk2.amr.corp.intel.com>
References: <20060815214914.GA5307@nostromo.devel.redhat.com><Pine.CYG.4.58.0608151532070.2316@mawilli1-desk2.amr.corp.intel.com><20060815154444.286e12ed@localhost.localdomain>
 <20060815.155612.111203542.davem@davemloft.net>
ReplyTo: "Mitch Williams" <mitch.a.williams@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 15 Aug 2006, David Miller wrote:
>
> I agree that whitespace in device names push the limits of sanity.
>
> But if we believe that, we should enforce it in dev_valid_name().
>
> Does anyone really mind if I add the whitespace check there?
>

I have no objections.  It would certainly make life easier.

OTOH, "push[ing] the limits of sanity" probably describes half of the
subscribers to netdev.  But that's neither here nor there.

-Mitch
