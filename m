Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269709AbTGaQgb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 12:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272529AbTGaQgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 12:36:31 -0400
Received: from mail.kroah.org ([65.200.24.183]:42961 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269709AbTGaQg3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 12:36:29 -0400
Date: Thu, 31 Jul 2003 09:36:39 -0700
From: Greg KH <greg@kroah.com>
To: Michael Bakos <bakhos@msi.umn.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: "Badness in pci_find_subsys"
Message-ID: <20030731163639.GA3555@kroah.com>
References: <Pine.SGI.4.33.0307311059540.17528-300000@ir12.msi.umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SGI.4.33.0307311059540.17528-300000@ir12.msi.umn.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 31, 2003 at 11:05:13AM -0500, Michael Bakos wrote:
> Kernel version: 2.6.0-test1
> CPU type: x86-64 (Opteron)
> PCI information attached.
> 
> I get: Badness in pci_find_subsys at drivers/pci/search.c:132 comming from
> 2 different things(one seems to be from the tg3 ethernet driver and the
> other from the ide driver), I also attached the exact call trace (before
> the pci information).

Known issue, it's fixed in the x86_64 tree and hopefully will make it to
Linus's tree sometime soon.

thanks,

greg k-h
