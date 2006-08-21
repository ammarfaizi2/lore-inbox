Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932126AbWHUS13@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbWHUS13 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 14:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932129AbWHUS13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 14:27:29 -0400
Received: from ns2.suse.de ([195.135.220.15]:49592 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932126AbWHUS13 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 14:27:29 -0400
Date: Mon, 21 Aug 2006 11:25:42 -0700
From: Greg KH <greg@kroah.com>
To: Daniel Ritz <daniel.ritz-ml@swissonline.ch>
Cc: Greg KH <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>,
       Jean Delvare <khali@linux-fr.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-pci <linux-pci@atrey.karlin.mff.cuni.cz>, stable@kernel.org
Subject: Re: [PATCH] PCI: fix ICH6 quirks
Message-ID: <20060821182542.GF17295@kroah.com>
References: <200608181650.41869.daniel.ritz-ml@swissonline.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608181650.41869.daniel.ritz-ml@swissonline.ch>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2006 at 04:50:40PM +0200, Daniel Ritz wrote:
> [PATCH] PCI: fix ICH6 quirks
> 
> - add the ICH6(R) LPC to the ICH6 ACPI quirks. currently only the ICH6-M is
>   handled. [ PCI_DEVICE_ID_INTEL_ICH6_1 is the ICH6-M LPC, ICH6_0 is the ICH6(R) ]
> - remove the wrong quirk calling asus_hides_smbus_lpc() for ICH6. the register
>   modified in asus_hides_smbus_lpc() has a different meaning in ICH6.
> 
> Signed-off-by: Daniel Ritz <daniel.ritz@gmx.ch>
> Cc: Jean Delvare <khali@linux-fr.org>

Queued to -stable, thanks.

greg k-h
