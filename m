Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262635AbVDHAMV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262635AbVDHAMV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 20:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262630AbVDHALC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 20:11:02 -0400
Received: from mail.kroah.org ([69.55.234.183]:58605 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262631AbVDHAKk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 20:10:40 -0400
Date: Thu, 7 Apr 2005 17:07:45 -0700
From: Greg KH <greg@kroah.com>
To: Rolf Eike Beer <eike-hotplug@sf-tec.de>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH] PCI Hotplug: remove code duplication in drivers/pci/hotplug/ibmphp_pci.c
Message-ID: <20050408000745.GA7010@kroah.com>
References: <1112399271636@kroah.com> <200504021420.16772@bilbo.math.uni-mannheim.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504021420.16772@bilbo.math.uni-mannheim.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 02, 2005 at 02:20:11PM +0200, Rolf Eike Beer wrote:
> Greg KH wrote:
> > ChangeSet 1.2181.16.9, 2005/03/17 13:54:33-08:00, eike-hotplug@sf-tec.de
> >
> > [PATCH] PCI Hotplug: remove code duplication in
> > drivers/pci/hotplug/ibmphp_pci.c
> >
> > This patch removes some code duplication where if and else have the
> > same code at the beginning and the end of the branch.
> 
> Greg, as you correctly pointed out this patch if broken. It could never reach 
> the if branch and always uses the else branch. Please drop this one and 
> review the patch I sent on March 21th to pcihp-discuss for inclusion. It 
> removes much more duplication and handles this case correctly. Sorry, it 
> looks like I forgot to CC you. I'll bounce this mail to you.

Hm, care to send me a patch that backs the old one out?  Or just one
that fixes it properly, I can't really revert the old patch, now that
I'm not using bitkeeper :)

thanks,

greg k-h
