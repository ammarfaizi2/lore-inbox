Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266216AbUBRMtM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 07:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266499AbUBRMtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 07:49:12 -0500
Received: from uslink-66.173.43-133.uslink.net ([66.173.43.133]:26629 "EHLO
	dingdong.cryptoapps.com") by vger.kernel.org with ESMTP
	id S266216AbUBRMtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 07:49:09 -0500
Date: Wed, 18 Feb 2004 04:48:59 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Klaus Ethgen <Klaus@Ethgen.de>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [KERNEL] Re: TCP: Treason uncloaked DoS ??
Message-ID: <20040218124859.GA8382@dingdong.cryptoapps.com>
References: <20040218102725.GB3394@hathi.ethgen.de> <20040218105508.GA7320@dingdong.cryptoapps.com> <20040218124141.GA11303@hathi.ethgen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040218124141.GA11303@hathi.ethgen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 18, 2004 at 01:41:41PM +0100, Klaus Ethgen wrote:

> Well, not on this interface. only on my other.

So you have a packetshaper then?  By this I mean a PacketShaper from
packeteer (http://packeteer.com/prod-sol/products/packetshaper.cfm).

> But maybe there is some "interference" between the tc on eth0 and
> the eth1...

I can't see how, but I don't know your setup and/or config. to
determine what the packet path is.

If there is a PacketShaper near the machine, I'm going to suggest
taking that away and see if this message goes away.  If it's upstream
of course you can't do this.



  --cw
