Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262268AbVFSSOv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262268AbVFSSOv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Jun 2005 14:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262269AbVFSSOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Jun 2005 14:14:51 -0400
Received: from waste.org ([216.27.176.166]:18593 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262268AbVFSSOu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Jun 2005 14:14:50 -0400
Date: Sun, 19 Jun 2005 11:14:36 -0700
From: Matt Mackall <mpm@selenic.com>
To: Jeff Moyer <jmoyer@redhat.com>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: netpoll and the bonding driver
Message-ID: <20050619181436.GX27572@waste.org>
References: <17075.10995.498758.773092@segfault.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17075.10995.498758.773092@segfault.boston.redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2005 at 03:56:35PM -0400, Jeff Moyer wrote:
> Hi,
> 
> I'm trying to implement a netpoll hook for the bonding driver.

My first question would be: does this really make sense to do? Why not
just bind netpoll to one of the underlying devices?

-- 
Mathematics is the supreme nostalgia of our time.
