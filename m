Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261864AbVDKSAa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261864AbVDKSAa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 14:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261865AbVDKSAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 14:00:30 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:7019 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S261864AbVDKSAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 14:00:19 -0400
Date: Mon, 11 Apr 2005 10:59:52 -0700
From: Greg KH <gregkh@suse.de>
To: Ian Molton <spyro@f2s.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH add support for system on chip (SoC) devices.
Message-ID: <20050411175952.GB24070@suse.de>
References: <42569300.7070008@f2s.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42569300.7070008@f2s.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2005 at 03:19:44PM +0100, Ian Molton wrote:
> Hi.
> 
> This patch add support for a new 'System on Chip' or SoC bus type.
> 
> This allows common drivers used in different SoC devices to be shared in 
> a clean and healthy manner, for example, the MMC function on toshiba 
> t7l66xb, tc6393xb, and Compaq IPAQ ASIC3.
> 
> This is in common use in the handhelds.org CVS tree.
> 
> The only real issue is that drivers using this currently tend to assume 
> that the SoC is attached to a platfrom_bus. This can be resolved as and 
> when it becomes an issue for people.
> 
> Please apply.

Sorry, but I agree with everyone else.  Why do you need this?  Why is
this different from a platform device?

thanks,

greg k-h
