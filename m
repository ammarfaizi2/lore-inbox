Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932235AbWEWWte@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbWEWWte (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 18:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932267AbWEWWte
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 18:49:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:7849 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932235AbWEWWtd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 18:49:33 -0400
Date: Tue, 23 May 2006 15:47:18 -0700
From: Greg KH <greg@kroah.com>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Patrick Jefferson <patrick.jefferson@hp.com>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH] PCI: fix MMIO addressing collisions
Message-ID: <20060523224718.GA31629@kroah.com>
References: <4472FFDA.2040005@hp.com> <20060524020654.A19699@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060524020654.A19699@jurassic.park.msu.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2006 at 02:06:54AM +0400, Ivan Kokshaysky wrote:
> On Tue, May 23, 2006 at 12:28:10PM +0000, Patrick Jefferson wrote:
> > Clearing PCI Command bits fixes machine halts observed during sizing 
> > seqences using MMIO cycles. Clearing the bits is suggested by an 
> > implementation note in the PCI spec.
> 
> The patch is not acceptable. This was discussed back in 2002:
> 
>   http://www.uwsg.iu.edu/hypermail/linux/kernel/0212.2/index.html#978

I agree, it's not going to be accepted.

Patrick, are you trying to solve the same thing that Grant was back in
2002?  Why do you feel this patch is necessary?

thanks,

greg k-h
