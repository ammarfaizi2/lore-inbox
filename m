Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266251AbUA2Q5P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 11:57:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266252AbUA2Q5P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 11:57:15 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58837 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266251AbUA2Q5K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 11:57:10 -0500
Message-ID: <40193B43.7020904@pobox.com>
Date: Thu, 29 Jan 2004 11:56:35 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Wiran, Francis" <francis.wiran@hp.com>
CC: Greg KH <greg@kroah.com>, Hollis Blanchard <hollisb@us.ibm.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpqarray update
References: <CBD6B29E2DA6954FABAC137771769D6504E1596E@cceexc19.americas.cpqcorp.net>
In-Reply-To: <CBD6B29E2DA6954FABAC137771769D6504E1596E@cceexc19.americas.cpqcorp.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wiran, Francis wrote:
> check for negative value? That's odd. The pci_register_driver() in my
> copy of 2.4.24 kernel (drivers/pci/pci.c) looks something like this:
> 
> {
> 	count = 0;
> 
> 	for ....
> 		count += foo();
> 
> 	return count;
> }
> 
> 
> Or will it change in the future? The patch that I sent was based on what
> is in the current kernel.


Correct, Greg was referring to 2.6.x behavior of pci_register_driver(), 
which changed from 2.4.x.

	Jeff



