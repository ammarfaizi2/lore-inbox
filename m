Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266412AbUA2UPJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 15:15:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266416AbUA2UPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 15:15:08 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31130 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266412AbUA2UPE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 15:15:04 -0500
Message-ID: <401969BB.2020200@pobox.com>
Date: Thu, 29 Jan 2004 15:14:51 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Wiran, Francis" <francis.wiran@hp.com>
CC: Greg KH <greg@kroah.com>, Hollis Blanchard <hollisb@us.ibm.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpqarray update
References: <CBD6B29E2DA6954FABAC137771769D6504E1596F@cceexc19.americas.cpqcorp.net>
In-Reply-To: <CBD6B29E2DA6954FABAC137771769D6504E1596F@cceexc19.americas.cpqcorp.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wiran, Francis wrote:
> Ok. I'll make a patch when the behaviour changes, as per Greg's:
> 
> 
>>Yeah, I don't really like it either, but figured it was a 2.7 task to
>>clean it up properly.
> 
> 
> At 2.6.1, it still returns count.

Look closer:
2.4 behavior:  returns count.

2.6 behavior:  returns negative value on error, or returns 1 when no
controllers found, or returns number of controllers found.

	Jeff



