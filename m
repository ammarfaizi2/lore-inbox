Return-Path: <linux-kernel-owner+w=401wt.eu-S1751125AbXAVJfS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbXAVJfS (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 04:35:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbXAVJfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 04:35:18 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:4430 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751125AbXAVJfR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 04:35:17 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=mfzPRkyJmIStfOafeqVcHMktEplvqovYLH8KwJSDTl/UXxJL25Hr0G01+bE2azUgmBFcSOFXHzgXgGpeMpHnTUZl6N8qeH1rKc1xTJl6HtMquV0s25iihWgrOYc9O8Cg2ifbbq+fFrqm6kwHPyH7BmHjHXmoFNRxGg6BpjRXpRI=
Message-ID: <45B48549.1080209@gmail.com>
Date: Mon, 22 Jan 2007 18:35:05 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.9 (X11/20061220)
MIME-Version: 1.0
To: Paolo Ornati <ornati@fastwebnet.it>
CC: Robert Hancock <hancockr@shaw.ca>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
       Jens Axboe <jens.axboe@oracle.com>, Jeff Garzik <jeff@garzik.org>
Subject: Re: SATA exceptions triggered by XFS (since 2.6.18)
References: <20070121152932.6dc1d9fb@localhost>	<20070121174023.68402ade@localhost>	<45B3A392.6050609@shaw.ca>	<20070121202552.14cc29fe@localhost>	<45B42569.6030902@gmail.com> <20070122093823.1241be05@localhost>
In-Reply-To: <20070122093823.1241be05@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Ornati wrote:
>>> === START OF INFORMATION SECTION ===
>>> Model Family:     Seagate Barracuda 7200.7 and 7200.7 Plus family
>>> Device Model:     ST380817AS
>> I'll blacklist it.  Thanks.
> 
> Ok. It will be better if someone else with the same HD could confirm.
> 
> It looks so strange that an HD that works fine, and should support NCQ,
> have so big troubles that I can "freeze" it in less than a second by
> using XFS (while with ext3 I cannot, or at least it's very hard).

Yeap, certainly.  I'll ask people first before actually proceeding with 
the blacklisting.  I'm just getting a bit tired of tides of NCQ firmware 
problems.

Anyways, for the time being, you can easily turn off NCQ using sysfs. 
Please take a look at http://linux-ata.org/faq.html

-- 
tejun
