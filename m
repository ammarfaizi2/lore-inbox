Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030257AbWHXDiY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030257AbWHXDiY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 23:38:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030255AbWHXDiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 23:38:24 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:63201 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030252AbWHXDiX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 23:38:23 -0400
Message-ID: <44ED1F28.4070808@pobox.com>
Date: Wed, 23 Aug 2006 23:38:16 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: albertl@mail.com
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, Doug Maxey <dwm@enoyolf.org>,
       Unicorn Chang <uchang@tw.ibm.com>
Subject: Re: Merging libata PATA support into the base kernel
References: <1155144599.5729.226.camel@localhost.localdomain> <44ED1D93.3020203@tw.ibm.com>
In-Reply-To: <44ED1D93.3020203@tw.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Lee wrote:
> Alan Cox wrote:
>> Jeff (rightly) thinks the plan should be discussed publically, so here
>> is the plan
>>
>> For 2.6.19 to move the libata drivers to drivers/ata
>> Add a subset of the new PATA drivers living in -mm to the base kernel
>>
> 
> Is it planned for the pata_pdc2027x driver to be included in the
> subset of upstream PATA drivers? It would be nice to have the driver
> for the adapter hotplug on ppc64.

Yes.  That driver will go along with all the other PATA drivers in the 
#pata-drivers branch.

	Jeff



