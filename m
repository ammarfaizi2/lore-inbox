Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261997AbVCHAMM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261997AbVCHAMM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 19:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262012AbVCHACa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 19:02:30 -0500
Received: from peabody.ximian.com ([130.57.169.10]:1942 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261999AbVCGX7o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 18:59:44 -0500
Subject: Re: [RFC][PATCH] PCI bridge driver rewrite (rev 02)
From: Adam Belay <abelay@novell.com>
To: Jesse Barnes <jbarnes@sgi.com>
Cc: Jon Smirl <jonsmirl@gmail.com>, greg@kroah.com,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       len.brown@intel.com
In-Reply-To: <200503071543.31089.jbarnes@sgi.com>
References: <1110234742.2456.37.camel@localhost.localdomain>
	 <9e47339105030715395b7bc61e@mail.gmail.com>
	 <200503071543.31089.jbarnes@sgi.com>
Content-Type: text/plain
Date: Mon, 07 Mar 2005 18:57:22 -0500
Message-Id: <1110239842.12485.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-03-07 at 15:43 -0800, Jesse Barnes wrote:
> On Monday, March 7, 2005 3:39 pm, Jon Smirl wrote:
> > How is sys/bus/platform/* going to work for IA64 machine line SGI SVN?
> > SVN supports multiple simultaneously active legacy spaces, that means
> > that there can be multiple floppy, serial, ps/2, etc controllers.
> > Should these devices be hung off from the bridge they are on?
> 
> Probably, though no one in their right mind is going to put anything like that 
> on these machines (sn2 btw) :).  VGA cards will hopefully be the only devices 
> of this type that we'll have installed.
> 
> Jesse

Well, if the system supports ACPI, then in theory it could have any
number/configuration of legacy devices, and we'd know everything about
them including exactly where to put them in the device tree.  However, I
agree that legacy hardware will be less common in this architecture.

Adam


