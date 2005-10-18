Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932327AbVJREyO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932327AbVJREyO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 00:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932330AbVJREyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 00:54:14 -0400
Received: from mail.kroah.org ([69.55.234.183]:16347 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932327AbVJREyN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 00:54:13 -0400
Date: Mon, 17 Oct 2005 21:37:16 -0700
From: Greg KH <greg@kroah.com>
To: Roland Dreier <rolandd@cisco.com>
Cc: Matthew Wilcox <matthew@wil.cx>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH] PCI: Add pci_find_next_capability() to deal with >1 caps of same type
Message-ID: <20051018043716.GB9622@kroah.com>
References: <52mzl7pwrn.fsf@cisco.com> <20051018021033.GA12610@parisc-linux.org> <52ek6jpl8k.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52ek6jpl8k.fsf@cisco.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2005 at 08:17:15PM -0700, Roland Dreier wrote:
>     Matthew> I don't like having this loop duplicated.  How about the
>     Matthew> following?
> 
> Looks good to me -- I agree with wanting only one loop, but I wasn't
> clever enough to see how to avoid the duplication.
> 
> Greg, want me to send a new patch including this along with required
> the <linux/pci.h> changes again?

Yes, please do.  And all new PCI core exports should be _GPL please.

thanks,

greg k-h
