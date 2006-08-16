Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750998AbWHPNik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998AbWHPNik (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 09:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751008AbWHPNik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 09:38:40 -0400
Received: from mx1.redhat.com ([66.187.233.31]:13221 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750983AbWHPNij (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 09:38:39 -0400
Date: Wed, 16 Aug 2006 09:38:11 -0400
From: Bill Nottingham <notting@redhat.com>
To: "Giacomo A. Catenazzi" <cate@debian.org>
Cc: David Miller <davem@davemloft.net>, 7eggert@gmx.de, 7eggert@elstempel.de,
       shemminger@osdl.org, mitch.a.williams@intel.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: bonding: cannot remove certain named devices
Message-ID: <20060816133811.GA26471@nostromo.devel.redhat.com>
Mail-Followup-To: "Giacomo A. Catenazzi" <cate@debian.org>,
	David Miller <davem@davemloft.net>, 7eggert@gmx.de,
	7eggert@elstempel.de, shemminger@osdl.org,
	mitch.a.williams@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <6KfTz-OX-11@gated-at.bofh.it> <6KfTA-OX-15@gated-at.bofh.it> <E1GD8rX-0001cA-CV@be1.lrz> <20060815.171002.104028951.davem@davemloft.net> <44E2BC9C.1000101@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44E2BC9C.1000101@debian.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giacomo A. Catenazzi (cate@debian.org) said: 
> > Are you willing to work to add the special case code necessary to
> > handle whitespace characters in the device name over all of the kernel
> > code and also all of the userland tools too?
> 
> But if you don't handle spaces in userspace, you handle *, ?, [, ], $,
> ", ', \  in userspace? Should kernel disable also these (insane device
> chars) chars?

Don't forget unicode characters!

Seriously, while it might be insane to use some of these, I'm wondering
if trying to filter names is more work than fixing the tools.

Bill
