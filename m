Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262970AbVALAqG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262970AbVALAqG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 19:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262967AbVALAoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 19:44:11 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:34478 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262978AbVALAhx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 19:37:53 -0500
Date: Tue, 11 Jan 2005 16:37:28 -0800
From: Greg KH <greg@kroah.com>
To: Roland Dreier <roland@topspin.com>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
       tom.l.nguyen@intel.com
Subject: Re: [PATCH] PCI: Clean up printks in msi.c
Message-ID: <20050112003728.GC20607@kroah.com>
References: <52sm59yzsx.fsf@topspin.com> <Pine.LNX.4.61.0501101022500.26637@montezuma.fsmlabs.com> <20050110173133.GA30605@kroah.com> <52k6qlyyix.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52k6qlyyix.fsf@topspin.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2005 at 09:39:02AM -0800, Roland Dreier wrote:
>     Greg> I agree.  Roland, care to change it?
> 
> No problem, here's the patch without any "success" message.
> 
> 
> Add "PCI:" prefixes and fix up the formatting and grammar of printks
> in drivers/pci/msi.c.  The main motivation was to fix the shouting
> "MSI INIT SUCCESS" message printed when an MSI-using driver is first
> started, but while we're at it we might as well tidy up all the messages.
> 
> Signed-off-by: Roland Dreier <roland@topspin.com>

Applied, thanks.

greg k-h
