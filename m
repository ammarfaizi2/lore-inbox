Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965096AbWIECZb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965096AbWIECZb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 22:25:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965095AbWIECZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 22:25:31 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:29078 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965091AbWIECZa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 22:25:30 -0400
Message-ID: <44FCE016.6080600@garzik.org>
Date: Mon, 04 Sep 2006 22:25:26 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Andras Mantia <amantia@kde.org>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: PATA drivers queued for 2.6.19
References: <44FC0779.9030405@garzik.org> <edi5uq$o4i$1@sea.gmane.org>
In-Reply-To: <edi5uq$o4i$1@sea.gmane.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andras Mantia wrote:
> Jeff Garzik wrote:
> 
>> I just pulled the "pata-drivers" branch of libata-dev.git into the
>> "upstream" branch, which means that Alan's libata PATA driver collection
>> is now queued for 2.6.19.
>>
>> Testing-wise, these PATA drivers have been Andrew Morton's -mm tree for
>> many months.  Community-wise, no one posted objections to the PATA
>> driver merge plan, when Alan posted it on LKML and linux-ide.
> 
> Does this include the patch to support the PATA port on the promise
> controllers (described here
> https://bugzilla.novell.com/show_bug.cgi?id=176249 ) ?

Unfortunately not.  This patch still lives in -mm (and branch 
promise-sata-pata).

Hopefully this can be merged once the init code is cleaned up some more.

	Jeff



