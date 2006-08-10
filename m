Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161170AbWHJL0H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161170AbWHJL0H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 07:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161173AbWHJL0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 07:26:07 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:32920 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161170AbWHJL0F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 07:26:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=XA76lnrB6X3KlWPGZ+OdX+cld4L7FTa4ZCr7kKwhhbjcGNCBSEtRT9Ys+kNAXw3Tm2IsVi3BDO85NPmJ/mRwWLZTPGjOOyTlGbxRaUuQnE6rdFimfUP/0nbfuzoRUiyyS4qt+G/OcwcgQ17pRWdfZOWFwPnL/NxNV+RKKK9VReI=
Message-ID: <44DB17C4.2070908@gmail.com>
Date: Thu, 10 Aug 2006 20:25:56 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [SATA] max-sect and sii-m15w branches merged
References: <44DB106C.6090504@garzik.org>
In-Reply-To: <44DB106C.6090504@garzik.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> I just merged the max-sect and sii-m15w branches into the upstream branch.
> 
> This means that the following two changes are queued for 2.6.19:
> 
> * increase max sectors from 200 to 256 (for lba28)
> * better mod15write support for sata_sil

Are we ready for m15w-iterate-over-large-write patch?  It has been used 
by many people for quite some time and works great.  If you think we can 
merge that patch, I'll port it over #upstream.

Thanks.

-- 
tejun
