Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932441AbWFGWsP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932441AbWFGWsP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 18:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932454AbWFGWsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 18:48:15 -0400
Received: from ns2.suse.de ([195.135.220.15]:11706 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932441AbWFGWsO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 18:48:14 -0400
Date: Wed, 7 Jun 2006 15:45:35 -0700
From: Greg KH <greg@kroah.com>
To: Marcelo Feitoza Parisi <marcelo@feitoza.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Need pci=conf1 to have my PCI slots working
Message-ID: <20060607224535.GB17111@kroah.com>
References: <44872F33.7020708@feitoza.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44872F33.7020708@feitoza.com.br>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2006 at 04:55:31PM -0300, Marcelo Feitoza Parisi wrote:
> Motherboard: Asus P5VDC-MX
> Northbridge: VIA P4M800 PRO
> Southbridge: VIA VT8251
> Kernel Version: 2.6.15-23-386 (Ubuntu Dapper Drake original kernel)
> 
> My PCI cards where not being showed on lspci and lshw. Tried to change
> cards, change slots, nothing worked. So someone told me to try pci=conf1
> in my boot, and it worked.He then told me that you people might be
> interested in hearing that was necessary and then cowardly ran off.

Can you try the latest 2.6.17-rc6 kernel?  This should hopefully "just
work" there.

thanks,

greg k-h
