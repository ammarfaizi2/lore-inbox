Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265286AbUEZRat@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265286AbUEZRat (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 13:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265637AbUEZRat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 13:30:49 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55530 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265286AbUEZRar
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 13:30:47 -0400
Message-ID: <40B4D439.3080504@pobox.com>
Date: Wed, 26 May 2004 13:30:33 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: "Durairaj, Sundarapandian" <sundarapandian.durairaj@intel.com>,
       Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, marcelo.tosatti@cyclades.com,
       "Carbonari, Steven" <steven.carbonari@intel.com>,
       "Seshadri, Harinarayanan" <harinarayanan.seshadri@intel.com>
Subject: Re: [BK PATCH] PCI Express patches for 2.4.27-pre3
References: <6B09584CC3D2124DB45C3B592414FA83021EB9E5@bgsmsx402.gar.corp.intel.com> <20040526170345.GB28578@kroah.com>
In-Reply-To: <20040526170345.GB28578@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Wed, May 26, 2004 at 11:59:43AM +0530, Durairaj, Sundarapandian wrote:
> 
>>I think its important that we have this patch for 2.4 kernel as well, as
>>it will enable the PCI express devices to access extended config space
>>(above 256 bytes), where all Advance feature of PCI Express config
>>registers resides.
> 
> 
> Are there any drivers or devices on the market today that need access to
> this extended config space?


"need"?  Not AFAIK.  Not yet, anyway.

Most PCI-Ex devices I've seen are designed such that they work under 
OS's and drivers that do not support the extended configuration area.

	Jeff


