Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262371AbVAJRxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262371AbVAJRxN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 12:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262370AbVAJRu5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 12:50:57 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:8868 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262336AbVAJRbk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 12:31:40 -0500
Date: Mon, 10 Jan 2005 09:31:34 -0800
From: Greg KH <greg@kroah.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Roland Dreier <roland@topspin.com>, linux-kernel@vger.kernel.org,
       tom.l.nguyen@intel.com
Subject: Re: [PATCH] PCI: Clean up printks in msi.c
Message-ID: <20050110173133.GA30605@kroah.com>
References: <52sm59yzsx.fsf@topspin.com> <Pine.LNX.4.61.0501101022500.26637@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0501101022500.26637@montezuma.fsmlabs.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2005 at 10:23:22AM -0700, Zwane Mwaikambo wrote:
> On Mon, 10 Jan 2005, Roland Dreier wrote:
> 
> > Add "PCI:" prefixes and fix up the formatting and grammar of printks
> > in drivers/pci/msi.c.  The main motivation was to fix the shouting
> > "MSI INIT SUCCESS" message printed when an MSI-using driver is first
> > started, but while we're at it we might as well tidy up all the messages.
> 
> I reckon just get rid of that MSI init success message entirely.

I agree.  Roland, care to change it?

thanks,

greg k-h
