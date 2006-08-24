Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751536AbWHXNwH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751536AbWHXNwH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 09:52:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751542AbWHXNwH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 09:52:07 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:19335 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751536AbWHXNwE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 09:52:04 -0400
Message-ID: <44EDAEFC.6000609@pobox.com>
Date: Thu, 24 Aug 2006 09:51:56 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH] libata : Add 40pin "short" cable support, honour drive
 side speed detection
References: <1156188229.18887.56.camel@localhost.localdomain>	 <44ED4DB5.10400@pobox.com> <1156417070.3007.64.camel@localhost.localdomain>
In-Reply-To: <1156417070.3007.64.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Ar Iau, 2006-08-24 am 02:56 -0400, ysgrifennodd Jeff Garzik:
>> ACK, but you need to split this up into core (#upstream) and PATA 
>> (#pata-drivers) patches.
> 
> Its not really needed until you have pata drivers so I was planning to
> submit it only for the pata-drivers side of things ?

The standard policy, in place since you began, has been to push core 
stuff into #upstream, and the driver side into #pata-drivers.

That way core changes aren't hidden away in #pata-drivers, and new 
PATA-related code is always compiled -- just like it will be, when the 
PATA drivers are in mainline.

	Jeff


