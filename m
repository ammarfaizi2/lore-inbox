Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262495AbULOViV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262495AbULOViV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 16:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262502AbULOViV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 16:38:21 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:59629 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262495AbULOVhl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 16:37:41 -0500
Date: Wed, 15 Dec 2004 13:37:26 -0800
From: Greg KH <greg@kroah.com>
To: long <tlnguyen@snoqualmie.dp.intel.com>
Cc: linux-kernel@vger.kernel.org, tom.l.nguyen@intel.com
Subject: Re: [PATCH]PCI Express Port Bus Driver
Message-ID: <20041215213726.GA11408@kroah.com>
References: <200412152227.iBFMRPPR027565@snoqualmie.dp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412152227.iBFMRPPR027565@snoqualmie.dp.intel.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2004 at 02:27:25PM -0800, long wrote:
> +config PCIEPORTBUS
> +	bool "PCI Express support"
> +	depends on PCI_GOMMCONFIG

This should also work if PCI_GOANY is selected, right?  Otherwise this
feature will never be turned on by any distro :(

thanks,

greg k-h
