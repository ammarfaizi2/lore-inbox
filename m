Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262241AbULRAJh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262241AbULRAJh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 19:09:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262245AbULRAHq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 19:07:46 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:55698 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262241AbULRAFo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 19:05:44 -0500
Date: Fri, 17 Dec 2004 16:05:18 -0800
From: Greg KH <greg@kroah.com>
To: long <tlnguyen@snoqualmie.dp.intel.com>
Cc: linux-kernel@vger.kernel.org, tom.l.nguyen@intel.com
Subject: Re: [PATCH]PCI Express Port Bus Driver
Message-ID: <20041218000518.GA24756@kroah.com>
References: <200412152227.iBFMRPPR027565@snoqualmie.dp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412152227.iBFMRPPR027565@snoqualmie.dp.intel.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2004 at 02:27:25PM -0800, long wrote:
> +struct bus_type pcie_port_bus_type = {
> +	.name 		= "PCIE port bus",

Ick, that puts spaces in the sysfs directory.  Why not just use
"pci_express"?

thanks,

greg k-h
