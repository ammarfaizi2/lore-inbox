Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030476AbWIMB2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030476AbWIMB2v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 21:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030477AbWIMB2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 21:28:51 -0400
Received: from nz-out-0102.google.com ([64.233.162.195]:18809 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1030476AbWIMB2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 21:28:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=hX4QRwHTK9Ut7lGreus7HkYYhJHp8lhQx83Zn821TipaLMX2HglZdewu1+7R7jHzdy7t0hX/pnj/xBr5msWXM4DkriQWowqaKCgdWVfOKJ86bvNWnDt6wMbcuBKtViEeHLWvdI5gOM8aNNDjVl3sh/kYtgWC36sRJvF0CLbcMyM=
Message-ID: <45075EBC.6040500@gmail.com>
Date: Wed, 13 Sep 2006 10:28:28 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060713)
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: Michael Tokarev <mjt@tls.msk.ru>,
       Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Vendor field with USB, [SP]ATA etc-attached disks
References: <4505A612.8070603@tls.msk.ru> <4505BA2B.1020105@garzik.org> <4506AB4B.9010801@gmail.com> <45075D73.5030005@garzik.org>
In-Reply-To: <45075D73.5030005@garzik.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> For the time being, we'll have to live with boilerplate ATA vendor and 
>> truncated vendor ID.  There are plans to make libata independent from 
> 
> Truncated model ID, I presume you mean.

Yeap.

>> SCSI which should solve the problem but it will take quite some time.
> 
> Since ATA does not distinguish between vendor and model, you can't 
> really solve the problem.  Two high volume disk vendors don't bother to 
> put a vendor name in the model string at all.

I meant by being solved "not printing emulated SCSI stuff including 
vendor ID while printing model ID fully and other ATA stuff".

-- 
tejun
