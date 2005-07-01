Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263133AbVGAAd7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263133AbVGAAd7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 20:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263152AbVGAAd6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 20:33:58 -0400
Received: from fmr22.intel.com ([143.183.121.14]:42404 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S263133AbVGAAd5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 20:33:57 -0400
Date: Thu, 30 Jun 2005 17:33:25 -0700
From: Rajesh Shah <rajesh.shah@intel.com>
To: Greg KH <greg@kroah.com>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Kristen Accardi <kristen.c.accardi@intel.com>, rajesh.shah@intel.com,
       gregkh@suse.de, ak@suse.de, len.brown@intel.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       acpi-devel@lists.sourceforge.net
Subject: Re: [patch 2/2] i386/x86_64: collect host bridge resources v2
Message-ID: <20050630173322.A8366@unix-os.sc.intel.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
References: <20050602224147.177031000@csdlinux-1> <20050602224327.051278000@csdlinux-1> <20050628155152.A24551@jurassic.park.msu.ru> <1119982914.19258.6.camel@whizzy> <20050629000300.A26118@jurassic.park.msu.ru> <20050630160506.GD6828@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050630160506.GD6828@kroah.com>; from greg@kroah.com on Thu, Jun 30, 2005 at 09:05:06AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2005 at 09:05:06AM -0700, Greg KH wrote:
> > 
> > Probably there is a conflict between e820 map and root bus ranges
> > reported by ACPI. I think that it would be better to just drop
> > gregkh-pci-pci-collect-host-bridge-resources-02.patch rather than
> > try to fix it, at least until such conflicts can be resolved in
> > a sane way.
> 
> Ok, I'll drop it.  Any objections to me doing this?
> 
OK with me. I actually think there are interactions between other
patches that may also be the cause for some of the problems
reported recently. However, I'm mostly out for the next 2
weeks, and will look at this more closely when I return.

Rajesh
