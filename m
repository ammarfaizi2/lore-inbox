Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261374AbVA1Bll@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261374AbVA1Bll (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 20:41:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbVA1Bll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 20:41:41 -0500
Received: from adsl-67-120-171-161.dsl.lsan03.pacbell.net ([67.120.171.161]:35090
	"HELO linuxace.com") by vger.kernel.org with SMTP id S261374AbVA1Blk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 20:41:40 -0500
Date: Thu, 27 Jan 2005 17:41:39 -0800
From: Phil Oester <kernel@linuxace.com>
To: "David S. Miller" <davem@davemloft.net>, Robert.Olsson@data.slu.se,
       akpm@osdl.org, torvalds@osdl.org, alexn@dsv.su.se, kas@fi.muni.cz,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: Memory leak in 2.6.11-rc1?
Message-ID: <20050128014139.GA16371@linuxace.com>
References: <20050123023248.263daca9.akpm@osdl.org> <20050123200315.A25351@flint.arm.linux.org.uk> <20050124114853.A16971@flint.arm.linux.org.uk> <20050125193207.B30094@flint.arm.linux.org.uk> <20050127082809.A20510@flint.arm.linux.org.uk> <20050127004732.5d8e3f62.akpm@osdl.org> <16888.58622.376497.380197@robur.slu.se> <20050127164918.C3036@flint.arm.linux.org.uk> <20050127123326.2eafab35.davem@davemloft.net> <20050128001701.D22695@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050128001701.D22695@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2005 at 12:17:01AM +0000, Russell King wrote:
> On Thu, Jan 27, 2005 at 12:33:26PM -0800, David S. Miller wrote:
> > So they won't be listed in /proc/net/rt_cache (since they've been
> > removed from the lookup table) but they will be accounted for in
> > /proc/net/stat/rt_cache until the final release is done on the
> > routing cache object and it can be completely freed up.
> > 
> > Do you happen to be using IPV6 in any way by chance?
> 
> Yes.  Someone suggested this evening that there may have been a recent
> change to do with some IPv6 refcounting which may have caused this
> problem.  Is that something you can confirm?

FWIW, I do not use IPv6, and it is not compiled into the kernel.

Phil
