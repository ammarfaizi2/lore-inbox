Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262403AbVAUQmh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262403AbVAUQmh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 11:42:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262419AbVAUQlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 11:41:49 -0500
Received: from dialin-164-213.tor.primus.ca ([216.254.164.213]:2688 "EHLO
	node1.opengeometry.net") by vger.kernel.org with ESMTP
	id S262423AbVAUQie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 11:38:34 -0500
Date: Thu, 20 Jan 2005 17:49:11 -0500
From: William Park <opengeometry@yahoo.ca>
To: Daniel Drake <dsd@gentoo.org>
Cc: Andrew Morton <akpm@osdl.org>, Helge Hafting <helge.hafting@hist.no>,
       rddunlap@osdl.org, viro@parcelfarce.linux.theplanet.co.uk,
       jhf@rivenstone.net, linux-kernel@vger.kernel.org, neilb@cse.unsw.edu.au
Subject: Re: [PATCH] Configurable delay before mounting root device
Message-ID: <20050120224911.GA2791@node1.opengeometry.net>
Mail-Followup-To: Daniel Drake <dsd@gentoo.org>,
	Andrew Morton <akpm@osdl.org>,
	Helge Hafting <helge.hafting@hist.no>, rddunlap@osdl.org,
	viro@parcelfarce.linux.theplanet.co.uk, jhf@rivenstone.net,
	linux-kernel@vger.kernel.org, neilb@cse.unsw.edu.au
References: <20050114002352.5a038710.akpm@osdl.org> <20050116005930.GA2273@zion.rivenstone.net> <41EC7A60.9090707@gentoo.org> <20050118003413.GA26051@parcelfarce.linux.theplanet.co.uk> <41EC5207.3030003@osdl.org> <41ECC8AF.9020404@hist.no> <20050118004935.7bd4a099.akpm@osdl.org> <41F01ADA.60605@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41F01ADA.60605@gentoo.org>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2005 at 08:55:54PM +0000, Daniel Drake wrote:
> Adds a boot parameter which can be used to specify a delay (in seconds) 
> before the root device is decoded/discovered/mounted.
> 
> Example usage for 10 second delay:
> 
> 	rootdelay=10
> 
> Useful for usb-storage devices which no longer make their partitions 
> immediately available, and for other storage devices which require some 
> "spin-up" time.
> 
> Signed-off-by: Daniel Drake <dsd@gentoo.org>

Very concise.  It's much better than 2.4 patch or its 2.6 adaptation (my
patch)...

-- 
William Park <opengeometry@yahoo.ca>, Toronto, Canada
Slackware Linux -- because I can type.
