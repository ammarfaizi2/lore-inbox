Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265719AbUEZRRZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265719AbUEZRRZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 13:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265723AbUEZRRZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 13:17:25 -0400
Received: from mail.kroah.org ([65.200.24.183]:41687 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265719AbUEZRRX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 13:17:23 -0400
Date: Wed, 26 May 2004 10:03:45 -0700
From: Greg KH <greg@kroah.com>
To: "Durairaj, Sundarapandian" <sundarapandian.durairaj@intel.com>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, marcelo.tosatti@cyclades.com,
       "Carbonari, Steven" <steven.carbonari@intel.com>,
       "Seshadri, Harinarayanan" <harinarayanan.seshadri@intel.com>
Subject: Re: [BK PATCH] PCI Express patches for 2.4.27-pre3
Message-ID: <20040526170345.GB28578@kroah.com>
References: <6B09584CC3D2124DB45C3B592414FA83021EB9E5@bgsmsx402.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6B09584CC3D2124DB45C3B592414FA83021EB9E5@bgsmsx402.gar.corp.intel.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2004 at 11:59:43AM +0530, Durairaj, Sundarapandian wrote:
> I think its important that we have this patch for 2.4 kernel as well, as
> it will enable the PCI express devices to access extended config space
> (above 256 bytes), where all Advance feature of PCI Express config
> registers resides.

Are there any drivers or devices on the market today that need access to
this extended config space?

I agree that if customers want this kind of new features, they should
use the 2.6 kernel.

thanks,

greg k-h
