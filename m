Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965263AbVKBVgv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965263AbVKBVgv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 16:36:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965268AbVKBVgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 16:36:51 -0500
Received: from hera.kernel.org ([140.211.167.34]:59541 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S965263AbVKBVgu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 16:36:50 -0500
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: Can I reduce CPU use of conntrack/masq?
Date: Wed, 2 Nov 2005 13:36:38 -0800
Organization: OSDL
Message-ID: <20051102133638.77852188@dxpl.pdx.osdl.net>
References: <200511021450.47657.R00020C@freescale.com>
	<69304d110511021223m59716878qc247ab96d8c1e24e@mail.gmail.com>
	<200511021551.52823.R00020C@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1130967398 26495 10.8.0.74 (2 Nov 2005 21:36:38 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Wed, 2 Nov 2005 21:36:38 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 1.9.15 (GTK+ 2.6.10; x86_64-redhat-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Nov 2005 15:51:52 -0500
Steve Snyder <R00020C@freescale.com> wrote:

> On Wednesday 02 November 2005 15:23, Antonio Vargas wrote:
> > On 11/2/05, Steve Snyder <R00020C@freescale.com> wrote:
> [snip]
> > > I wonder if I can improve conntrack/masq performance at the expense of
> > > flexibility.  This will be a closed system, with simple and static
> > > routing.  Are there any trade-offs I can make to sacrifice unneeded
> > > flexibility in routing for reduced CPU utilization in conntrack/masq?
> > 
> > Hmmm... totally untested and don't know the details of UWB but...
> > can't you simply ether-bridge the interfaces instead of masquerading?
> > It should need less CPU
> 
> Hmm...  I'm not familiar with ether-bridge, and Google turns up only
> commercial products and BSD references.

It in the kernel already! Look at 
	http://linux-net.osdl.org/index.php/Bridge
For more info

-- 
Stephen Hemminger <shemminger@osdl.org>
OSDL http://developer.osdl.org/~shemminger
