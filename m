Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262846AbULRHlo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262846AbULRHlo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 02:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262847AbULRHln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 02:41:43 -0500
Received: from waste.org ([216.27.176.166]:59798 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262846AbULRHlm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 02:41:42 -0500
Date: Fri, 17 Dec 2004 23:41:37 -0800
From: Matt Mackall <mpm@selenic.com>
To: Park Lee <parklee_sel@yahoo.com>
Cc: linux-kernel@vger.kernel.org, ipsec-tools-devel@lists.sourceforge.net
Subject: Re: Issue on netconsole vs. Linux kernel oops
Message-ID: <20041218074137.GA28322@waste.org>
References: <20041217164419.GO2767@waste.org> <20041218060134.77655.qmail@web51503.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041218060134.77655.qmail@web51503.mail.yahoo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2004 at 10:01:34PM -0800, Park Lee wrote:
> On Fri, 17 Dec 2004 at 08:44, Matt Mackall wrote:
> >
> > Netconsole builds very simple IPv4 packets by hand 
> > without the use of the rest of the IP stack. This 
> > is how it continues to work when the system is 
> > crashing. So it will never be able to build IPSEC 
> > packets.
> > Nor is it likely to do IPv6 any time soon.
> >
> > You can probably get it to work by using a 
> > different IP address for netconsole than you use 
> > for IPSEC, and set up the receiving end to
> > recognize packets from that address as normal 
> > unencrypted IPv4.
> 
> Thank you.
> 
> But that will need at least 3 computers(i.e. 2 for
> IPsec, 1 for receiving end), Am I right?

No, you should be able to configure a non-IPSsec interface on the
receiver, possibly at a fourth address.

-- 
Mathematics is the supreme nostalgia of our time.
