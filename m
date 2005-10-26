Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964930AbVJZVRI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964930AbVJZVRI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 17:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964932AbVJZVRI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 17:17:08 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:34511 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964930AbVJZVRG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 17:17:06 -0400
Date: Wed, 26 Oct 2005 22:17:05 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Laurent riffard <laurent.riffard@free.fr>
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [RFC patch 0/3] remove pci_driver.owner and .name fields
Message-ID: <20051026211705.GS7992@ftp.linux.org.uk>
References: <20051026204802.123045000@antares.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051026204802.123045000@antares.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2005 at 10:48:02PM +0200, Laurent riffard wrote:
> I'm willing to submit patches to remove pci_driver.owner and .name
> fields. pci_driver.driver.owner and .name will be used instead.
> 
> Patch 1 prepares the core pci code for future removal of the 2
> fields, but actually do not remove them. As suggested by Al Viro,
> pci_driver.driver.owner will be set by pci_register_driver.
> 
> Patch 2 is an example of driver's update. There will be lots of
> patches like this.
> 
> Patch 3 is the final touch, after all pci_driver.name and
> pci_driver.owner are removed.
> 
> Any comments ? Feel free to correct my bad english.

After 2.6.14 gets released, please...
