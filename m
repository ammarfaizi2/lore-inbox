Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263280AbTCNIK4>; Fri, 14 Mar 2003 03:10:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263274AbTCNIKz>; Fri, 14 Mar 2003 03:10:55 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:12043 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S263280AbTCNIKz>; Fri, 14 Mar 2003 03:10:55 -0500
Date: Fri, 14 Mar 2003 08:21:42 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Subject: Re: [PATCH] i2c driver changes for 2.5.64
Message-ID: <20030314082142.B11701@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
	sensors@stimpy.netroedge.com
References: <10476033153504@kroah.com> <1047603318248@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1047603318248@kroah.com>; from greg@kroah.com on Thu, Mar 13, 2003 at 04:55:00PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 13, 2003 at 04:55:00PM -0800, Greg KH wrote:
> ChangeSet 1.1106, 2003/03/13 10:50:41-08:00, greg@kroah.com
> 
> i2c: get i2c-ali15x3 driver to actually bind to a PCI device.

OOPS, should take a look at all patches first before complaining :)

>  static struct pci_device_id ali15x3_ids[] __devinitdata = {
> +	{
> +	.vendor =	PCI_VENDOR_ID_AL,
> +	.device =	PCI_DEVICE_ID_AL_M7101,
> +	.subvendor =	PCI_ANY_ID,
> +	.subdevice =	PCI_ANY_ID,
> +	},

The indentation looks a bit b0rked..

