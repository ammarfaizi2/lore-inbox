Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750718AbWHRGSi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbWHRGSi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 02:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbWHRGSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 02:18:38 -0400
Received: from mail.mailmij.org ([82.93.140.149]:51675 "EHLO mail.mailmij.org")
	by vger.kernel.org with ESMTP id S1750718AbWHRGSh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 02:18:37 -0400
Date: Fri, 18 Aug 2006 08:18:35 +0200
From: danny@mailmij.org
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: stable@kernel.org, Adrian Bunk <bunk@stusta.de>, danny@mailmij.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux1394-devel@lists.sourceforge.net
Subject: Re: [PATCH] fix for recently added firewire patch that breaks things on	ppc
Message-ID: <20060818081835.B32418@luna.ellen.dexterslabs.com>
References: <20060805151050.B24484@luna.ellen.dexterslabs.com> <1155118273.4040.81.camel@localhost.localdomain> <20060809151226.A31391@luna.ellen.dexterslabs.com> <1155201211.17187.128.camel@localhost.localdomain> <20060818072143.A32418@luna.ellen.dexterslabs.com> <44E55887.2050309@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <44E55887.2050309@s5r6.in-berlin.de>; from stefanr@s5r6.in-berlin.de on Fri, Aug 18, 2006 at 08:04:55AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2006 at 08:04:55AM +0200, Stefan Richter wrote:
> Danny Tholen wrote:
> >     Recently a patch was added for preliminary suspend/resume 
> >     handling on !PPC_PMAC. However, this broke both suspend and firewire
> >     on powerpc because it saves the pci state after the device has already
> >     been disabled.
> >  
> >     This moves the save state to before the pmac specific code.
> >     Please apply before 2.6.18.
> > 
> >     Signed-off-by: Danny Tholen <obiwan at mailmij.org>
> 
> This fix should go into 2.6.17.x and 2.6.16.yy too. (I sent the patch 
> with the regression also to Adrian recently.)
>
I'm sorry I should have mentioned that I already sent it to Greg KH.

Danny

