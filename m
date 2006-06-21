Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751301AbWFUT22@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbWFUT22 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 15:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbWFUT21
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 15:28:27 -0400
Received: from cantor2.suse.de ([195.135.220.15]:24728 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751301AbWFUT20 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 15:28:26 -0400
Date: Wed, 21 Jun 2006 12:25:19 -0700
From: Greg KH <greg@kroah.com>
To: Greg KH <gregkh@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [GIT PATCH] PCI patches for 2.6.17
Message-ID: <20060621192519.GA22142@kroah.com>
References: <20060621190246.GA20912@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060621190246.GA20912@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2006 at 12:02:46PM -0700, Greg KH wrote:
> Here are some PCI fixes and patches for 2.6.17.  They do a bunch of work
> getting MSI to work properly on ia64, and fix some other MSI issues.  We
> also added a few new sysfs attributes for PCI devices and add some more
> quirks and fix a few minor bugs.

Oh, and others have already noticed, the first patch in this series
fixes a build bug in the current tree where myri10ge.c does not build
due to PCI_CAP_ID_VNDR not being defined.

Sorry about that, it was a dependancy between the network driver tree
and mine.

thanks,

greg k-h
