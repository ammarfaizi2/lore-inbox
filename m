Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261200AbVDRX2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261200AbVDRX2R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 19:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261201AbVDRX2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 19:28:17 -0400
Received: from fmr22.intel.com ([143.183.121.14]:64660 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S261200AbVDRX2L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 19:28:11 -0400
Date: Mon, 18 Apr 2005 16:28:03 -0700
From: Rajesh Shah <rajesh.shah@intel.com>
To: Paul Ionescu <i_p_a_u_l@yahoo.com>
Cc: Rajesh Shah <rajesh.shah@intel.com>, acpi-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: hot-addacpi-hotplug-decouple-slot-power-state-changes-from-physical-hotplug.patch
Message-ID: <20050418162803.B408@unix-os.sc.intel.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
References: <20050416184613.85317.qmail@web50202.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050416184613.85317.qmail@web50202.mail.yahoo.com>; from i_p_a_u_l@yahoo.com on Sat, Apr 16, 2005 at 11:46:13AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 16, 2005 at 11:46:13AM -0700, Paul Ionescu wrote:
> 
> Was this setup supposed to work ?
> 
Not yet, sorry. This patch was simply decoupling the power state
of the device from its physical presence in the slot. It had 
nothing to do about programming p2p bridges and subordinate
devices correctly.

I know some folks from Fujitsu are working on this and should
be sending out patches shortly. Not sure if these will support
docking stations fully but even if they don't, we'll have a better
starting base to build on.

Rajesh
