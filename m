Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264326AbTLBTWx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 14:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264327AbTLBTWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 14:22:53 -0500
Received: from www.stereoconnection.ca ([216.16.235.58]:14275 "EHLO
	nic.NetDirect.CA") by vger.kernel.org with ESMTP id S264326AbTLBTWp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 14:22:45 -0500
Date: Tue, 2 Dec 2003 14:22:35 -0500
From: Chris Frey <cdfrey@netdirect.ca>
To: Harald Welte <laforge@netfilter.org>, linux-kernel@vger.kernel.org,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>
Subject: Re: [2.4.23] compile / link error in net/ipv4/netfilter
Message-ID: <20031202142235.A6455@netdirect.ca>
References: <20031201202853.A31914@netdirect.ca> <20031202082333.GI546@obroa-skai.de.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031202082333.GI546@obroa-skai.de.gnumonks.org>; from laforge@netfilter.org on Tue, Dec 02, 2003 at 01:53:33PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 02, 2003 at 01:53:33PM +0530, Harald Welte wrote:
> This is illegal, and 'make menuconfig' or 'make xconfig' should not
> allow you to combine the two of them.  Please describe how you managed
> to do that ;)

I had them all turned on as modules in an old config that I loaded, and
then turned module support off.

In theory the build system should prevent this, but I can see how that might
be hard to code (I'm not up to speed with the 2.4 build system internals)
so I called it user error on my part and continued on. :-)

- Chris

