Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262342AbUKKSDh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262342AbUKKSDh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 13:03:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262301AbUKKRzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 12:55:53 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:7576 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262339AbUKKRzQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 12:55:16 -0500
Date: Thu, 11 Nov 2004 09:54:19 -0800
From: Greg KH <greg@kroah.com>
To: Tim Hockin <thockin@google.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: small PCI probe patch for odd 64 bit BARs
Message-ID: <20041111175418.GA18811@kroah.com>
References: <20041111044809.GE19615@google.com> <20041110215142.3a81b426.akpm@osdl.org> <20041111173901.GH19615@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041111173901.GH19615@google.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2004 at 09:39:01AM -0800, Tim Hockin wrote:
> On Wed, Nov 10, 2004 at 09:51:42PM -0800, Andrew Morton wrote:
> > Tim Hockin <thockin@google.com> wrote:
> > >
> > > +			sz = pci_size(sz, 0xffffffff);
> > 
> > pci_size() takes three arguments, so this patch appears to not have been
> > runtime tested :( 
> 
> Doh, I sent the 2.4 patch.  This one should work on 2.6.9, though I do
> not have 2.6.9 running on this hardware, yet.  It was definitely runtime
> tested on 2.4.

I'll wait till you test this on 2.6 before applying it.  What kind of
hardware is this patch needed for?

thanks,

greg k-h
