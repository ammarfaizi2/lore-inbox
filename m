Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262432AbUKDUf3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262432AbUKDUf3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 15:35:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262415AbUKDUe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 15:34:59 -0500
Received: from crianza.bmb.uga.edu ([128.192.34.109]:640 "EHLO crianza")
	by vger.kernel.org with ESMTP id S262411AbUKDU3a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 15:29:30 -0500
Date: Thu, 4 Nov 2004 15:29:29 -0500
To: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sven Schuster <schuster.sven@gmx.de>
Subject: Re: Bad UDP checksums with 2.6.9
Message-ID: <20041104202929.GC542@porto.bmb.uga.edu>
Reply-To: foo@porto.bmb.uga.edu
References: <20041104054838.GC12763@porto.bmb.uga.edu> <20041104062834.GE12763@porto.bmb.uga.edu> <20041104173929.GA24782@zion.homelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041104173929.GA24782@zion.homelinux.com>
User-Agent: Mutt/1.5.6+20040818i
From: foo@porto.bmb.uga.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2004 at 06:39:29PM +0100, Sven Schuster wrote:
> 
> Hi,
> 
> On Thu, Nov 04, 2004 at 01:28:34AM -0500, foo@porto.bmb.uga.edu told us:
> > -CONFIG_IP_NF_AMANDA=y
> 
> did you see today's postings from Matthias Andree on this topic??
> It turned out that ip_conntrack_amanda changed some packets and
> that's why the UDP checksum was wrong. It seems like ip_conntrack_amanda
> is build into the kernel on one of your machines.
> 
> See
> http://marc.theaimsgroup.com/?l=linux-net&m=109957086306388&w=2
> http://marc.theaimsgroup.com/?l=linux-net&m=109957086416037&w=2
> 
> 
> Hope this helps

Yes, thanks.  I don't need that anyway, so I'll just get rid of it.

Thanks,
-ryan
