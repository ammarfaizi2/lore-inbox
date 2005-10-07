Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932677AbVJGWDq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932677AbVJGWDq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 18:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932678AbVJGWDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 18:03:46 -0400
Received: from mail.kroah.org ([69.55.234.183]:17321 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932677AbVJGWDp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 18:03:45 -0400
Date: Fri, 7 Oct 2005 15:03:25 -0700
From: Greg KH <greg@kroah.com>
To: William D Waddington <william.waddington@beezmo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFClue] pci_get_device, new driver model
Message-ID: <20051007220325.GA18638@kroah.com>
References: <43469FB8.50303@beezmo.com> <20051007214504.GA11545@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051007214504.GA11545@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2005 at 02:45:04PM -0700, Greg KH wrote:
> > If I just give in to the new driver model how/when do I associate
> > instance/minor numbers with boards found?

Oh, and if you don't convert to the new driver model, your driver will
just die a horrible death on pci hotplug systems, as it has no way to be
notified that the device was removed.

thanks,

greg k-h
