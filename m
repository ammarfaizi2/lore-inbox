Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262919AbVHESjr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262919AbVHESjr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 14:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263070AbVHEShR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 14:37:17 -0400
Received: from mail.kroah.org ([69.55.234.183]:21185 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262912AbVHESf2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 14:35:28 -0400
Date: Fri, 5 Aug 2005 11:35:06 -0700
From: Greg KH <greg@kroah.com>
To: Kristen Accardi <kristen.c.accardi@intel.com>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       rajesh.shah@intel.com
Subject: Re: [PATCH] 6700/6702PXH quirk
Message-ID: <20050805183505.GA32405@kroah.com>
References: <1123259263.8917.9.camel@whizzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1123259263.8917.9.camel@whizzy>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2005 at 09:27:42AM -0700, Kristen Accardi wrote:
> @@ -1127,3 +1159,5 @@ EXPORT_SYMBOL(pci_enable_msi);
>  EXPORT_SYMBOL(pci_disable_msi);
>  EXPORT_SYMBOL(pci_enable_msix);
>  EXPORT_SYMBOL(pci_disable_msix);
> +EXPORT_SYMBOL(disable_msi_mode);
> +EXPORT_SYMBOL(msi_add_quirk);

Why do these need to be exported?  It doesn't look like you are trying
to access these from a module, or do you have a patch that uses them
somewhere else?

thanks,

greg k-h
