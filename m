Return-Path: <linux-kernel-owner+w=401wt.eu-S1751946AbXAPX70@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751946AbXAPX70 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 18:59:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751949AbXAPX70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 18:59:26 -0500
Received: from vms042pub.verizon.net ([206.46.252.42]:44642 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946AbXAPX7Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 18:59:25 -0500
X-Greylist: delayed 3607 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Jan 2007 18:59:25 EST
Date: Tue, 16 Jan 2007 17:59:15 -0500
From: Eric Buddington <ebuddington@verizon.net>
Subject: Re: 2.6.20-rc4-mm1 USB (asix) problem
In-reply-to: <1168893137.19899.109.camel@dhollis-lnx.sunera.com>
To: David Hollis <dhollis@davehollis.com>
Cc: ebuddington@wesleyan.edu, linux-kernel@vger.kernel.org
Reply-to: ebuddington@wesleyan.edu
Message-id: <20070116225909.GA6932@pool-71-123-123-29.spfdma.east.verizon.net>
Organization: ECS Labs
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-disposition: inline
References: <20070113203113.GB14587@pool-71-123-103-45.spfdma.east.verizon.net>
 <1168889276.19899.105.camel@dhollis-lnx.sunera.com>
 <20070115195024.GA8135@pool-71-123-103-45.spfdma.east.verizon.net>
 <1168893137.19899.109.camel@dhollis-lnx.sunera.com>
User-Agent: Mutt/1.5.12-2006-07-14
X-Eric-conspiracy: there is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 15, 2007 at 08:32:17PM +0000, David Hollis wrote:
> Interesting.  It would really be something if your devices happen to
> work better with 0.  Wouldn't make much sense at all unfortunately.  If
> 0 works, could you also try setting it to 2 or 3?  The PHY select value
> is a bit field with the 0 bit being to select the onboard PHY, and 1 bit
> being to 'auto-select' the PHY based on link status.  The data sheet
> indicates that 3 should be the default, but all of the literature I have
> seen from ASIX says to write a 1 to it.

My hardware is ver. B1.

0, 2, and 3 all worked for me. 1, as before, does not.

'rmmod asix' takes a really long time (45-80s) with any setting, and
sometimes coincides with ksoftirqd pegging (99.9% CPU) for several
seconds.

-Eric
