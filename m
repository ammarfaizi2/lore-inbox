Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261369AbVFTAV5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbVFTAV5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Jun 2005 20:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261366AbVFTAV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Jun 2005 20:21:57 -0400
Received: from apollo.tuxdriver.com ([24.172.12.2]:62728 "EHLO
	apollo.tuxdriver.com") by vger.kernel.org with ESMTP
	id S261369AbVFTAVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Jun 2005 20:21:41 -0400
Date: Sun, 19 Jun 2005 20:21:20 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Matt Mackall <mpm@selenic.com>
Cc: Jeff Moyer <jmoyer@redhat.com>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: netpoll and the bonding driver
Message-ID: <20050620002118.GA16859@tuxdriver.com>
Mail-Followup-To: Matt Mackall <mpm@selenic.com>,
	Jeff Moyer <jmoyer@redhat.com>, netdev@oss.sgi.com,
	linux-kernel@vger.kernel.org
References: <17075.10995.498758.773092@segfault.boston.redhat.com> <20050619181436.GX27572@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050619181436.GX27572@waste.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 19, 2005 at 11:14:36AM -0700, Matt Mackall wrote:
> On Fri, Jun 17, 2005 at 03:56:35PM -0400, Jeff Moyer wrote:

> > I'm trying to implement a netpoll hook for the bonding driver.
> 
> My first question would be: does this really make sense to do? Why not
> just bind netpoll to one of the underlying devices?

Depending on the bonding mode, this would be very unlikely to work.
The other side of the link will still be expecting to talk to the
bond rather than to an individual link.

John
-- 
John W. Linville
linville@tuxdriver.com
