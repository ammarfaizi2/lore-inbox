Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751370AbVJSVqM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbVJSVqM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 17:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751372AbVJSVqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 17:46:12 -0400
Received: from mail.kroah.org ([69.55.234.183]:11745 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751370AbVJSVqL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 17:46:11 -0400
Date: Wed, 19 Oct 2005 14:45:38 -0700
From: Greg KH <greg@kroah.com>
To: Roland Dreier <rolandd@cisco.com>
Cc: gcoady@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci_ids: cleanup comments
Message-ID: <20051019214538.GA6999@kroah.com>
References: <4eedl1h86sarh1i5g42o7vi21i7v1ece2m@4ax.com> <524q7di40y.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <524q7di40y.fsf@cisco.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2005 at 02:35:25PM -0700, Roland Dreier wrote:
> I don't think I like this.  I prefer the format
> 
> 	#define PCI_DEVICE_ID_NEC_CBUS_1	0x0001 /* PCI-Cbus Bridge */
> 
> to taking two lines like
> 
> 	/* PCI-Cbus Bridge */
> 	#define PCI_DEVICE_ID_NEC_CBUS_1	0x0001
> 
> If some script can't handle the first format then I think the script
> should be fixed.

I agree, comments like this belong on the right hand side, it's cleaner
that way.

thanks,

greg k-h
