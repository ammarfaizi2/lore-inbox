Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030410AbVJ1Wxh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030410AbVJ1Wxh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 18:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030429AbVJ1Wxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 18:53:37 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:12008 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S1030410AbVJ1Wxg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 18:53:36 -0400
Date: Fri, 28 Oct 2005 16:53:35 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Greg KH <gregkh@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [GIT PATCH] PCI patches for 2.6.14
Message-ID: <20051028225335.GB21871@parisc-linux.org>
References: <20051028225055.GA21464@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051028225055.GA21464@kroah.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2005 at 03:50:55PM -0700, Greg KH wrote:
> Here are some PCI patches against your latest git tree.  They have all
> been in the -mm tree for a while with no problems.
> 
> Main things here are:
> 	- pci-ids.h cleanup
> 	- shpchp driver cleanup (very good job done here.)
> 	- more quirks added.

Does this just about clear you out of pending PCI patches?  I want to do
the s/hotplug_slot/pci_slot/ changes soon and it'll cause massive
conflicts with anyone else's pending work.

(I suppose I could do a gradual transition with a #define if preferred,
but a big bang seems like much less effort)
