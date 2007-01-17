Return-Path: <linux-kernel-owner+w=401wt.eu-S932126AbXAQNzU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbXAQNzU (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 08:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932180AbXAQNzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 08:55:20 -0500
Received: from vms046pub.verizon.net ([206.46.252.46]:63459 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932126AbXAQNzT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 08:55:19 -0500
Date: Wed, 17 Jan 2007 08:54:58 -0500
From: Eric Buddington <ebuddington@verizon.net>
Subject: Re: 2.6.20-rc4-mm1 USB (asix) problem
In-reply-to: <1169035248.11226.11.camel@dhollis-lnx.sunera.com>
To: David Hollis <dhollis@davehollis.com>
Cc: ebuddington@wesleyan.edu, linux-kernel@vger.kernel.org
Reply-to: ebuddington@wesleyan.edu
Message-id: <20070117135453.GA12703@pool-71-123-123-29.spfdma.east.verizon.net>
Organization: ECS Labs
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-disposition: inline
References: <20070113203113.GB14587@pool-71-123-103-45.spfdma.east.verizon.net>
 <1168889276.19899.105.camel@dhollis-lnx.sunera.com>
 <20070115195024.GA8135@pool-71-123-103-45.spfdma.east.verizon.net>
 <1168893137.19899.109.camel@dhollis-lnx.sunera.com>
 <20070116225909.GA6932@pool-71-123-123-29.spfdma.east.verizon.net>
 <1169035248.11226.11.camel@dhollis-lnx.sunera.com>
User-Agent: Mutt/1.5.12-2006-07-14
X-Eric-conspiracy: there is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 17, 2007 at 07:00:48AM -0500, David Hollis wrote:
> > 'rmmod asix' takes a really long time (45-80s) with any setting, and
> > sometimes coincides with ksoftirqd pegging (99.9% CPU) for several
> > seconds.
> 
> This I haven't seen before.  Does it occur even when the device is able
> to work (using 0 or the like from above)?  This may be due to something
> else in the USB subsystem or something.

Yes, the delay occurs even when the device works fine, and it results
in no suspicious dmesg's (just a couple of 'unregistering' messages).

I have no case when this delay doesn't occur; it's only in this
testing that I've had occasion to rmmod the driver at all. In and of
itself, it's not a big problem.

-Eric
