Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264944AbTFWCbF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 22:31:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264981AbTFWCbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 22:31:04 -0400
Received: from granite.he.net ([216.218.226.66]:33285 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S264944AbTFWCbD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 22:31:03 -0400
Date: Sun, 22 Jun 2003 19:44:33 -0700
From: Greg KH <greg@kroah.com>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch 2.5] PCI: fix non-hotplug build
Message-ID: <20030623024433.GA5500@kroah.com>
References: <20030621165948.A913@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030621165948.A913@jurassic.park.msu.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 21, 2003 at 04:59:48PM +0400, Ivan Kokshaysky wrote:
> Current BK won't build when CONFIG_HOTPLUG is not set due to
> undefined references to pci_destroy_dev in hotplug.c.
> I think it makes sense to not compile hotplug.c in this case at all.
> Also, this allows to get rid of several function which are unused
> in non-hotplug kernel.
> 
> Tested on Alpha.

Applied, thanks.

greg k-h
