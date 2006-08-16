Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbWHPAKE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWHPAKE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 20:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750714AbWHPAKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 20:10:04 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:42221
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750712AbWHPAKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 20:10:01 -0400
Date: Tue, 15 Aug 2006 17:10:02 -0700 (PDT)
Message-Id: <20060815.171002.104028951.davem@davemloft.net>
To: 7eggert@gmx.de, 7eggert@elstempel.de
Cc: shemminger@osdl.org, mitch.a.williams@intel.com, notting@redhat.com,
       mitch.a.williams@intel.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: bonding: cannot remove certain named devices
From: David Miller <davem@davemloft.net>
In-Reply-To: <E1GD8rX-0001cA-CV@be1.lrz>
References: <6KfTz-OX-11@gated-at.bofh.it>
	<6KfTA-OX-15@gated-at.bofh.it>
	<E1GD8rX-0001cA-CV@be1.lrz>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bodo Eggert <7eggert@elstempel.de>
Date: Wed, 16 Aug 2006 02:02:03 +0200

> Stephen Hemminger <shemminger@osdl.org> wrote:
> 
> > IMHO idiots who put space's in filenames should be ignored. As long as the
> > bonding code doesn't throw a fatal error, it has every right to return
> > "No such device" to the fool.
> 
> Maybe you should limit device names to eight uppercase characters and up to
> three characters extension, too. NOT! There is no reason to artificially
> impose limitations on device names, so don't do that.

Are you willing to work to add the special case code necessary to
handle whitespace characters in the device name over all of the kernel
code and also all of the userland tools too?

No?  Great, I'm glad that's settled.
