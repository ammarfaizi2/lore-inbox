Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161380AbWBUFZp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161380AbWBUFZp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 00:25:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161381AbWBUFZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 00:25:45 -0500
Received: from mail.kroah.org ([69.55.234.183]:27041 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161380AbWBUFZp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 00:25:45 -0500
Date: Mon, 20 Feb 2006 21:24:58 -0800
From: Greg KH <greg@kroah.com>
To: Shaohua Li <shaohua.li@intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       linux-pci <linux-pci@atrey.karlin.mff.cuni.cz>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/2]MSI(X) save/restore for suspend/resume
Message-ID: <20060221052458.GA30022@kroah.com>
References: <1139389898.14976.11.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1139389898.14976.11.camel@sli10-desk.sh.intel.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2006 at 05:11:38PM +0800, Shaohua Li wrote:
> It appears the two patches are lost since I updated them per Matthew
> Wilcox's comments. Resent them.
> 
> Add MSI(X) configure sapce save/restore in generic PCI helper.

This patch conflicts with msi patches in the -mm tree today.  Can you
redo it against the latest -mm tree?

thanks,

greg k-h
