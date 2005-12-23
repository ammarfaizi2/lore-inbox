Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161031AbVLWUHH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161031AbVLWUHH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 15:07:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161032AbVLWUHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 15:07:07 -0500
Received: from hermes.domdv.de ([193.102.202.1]:14596 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S1161031AbVLWUHF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 15:07:05 -0500
Message-ID: <43AC58E8.5000501@domdv.de>
Date: Fri, 23 Dec 2005 21:07:04 +0100
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051004)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
CC: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15rc6: ide oops+panic
References: <43AB20DA.2020506@domdv.de> <58cb370e0512230527l55810d0fif13d75f35723c1c3@mail.gmail.com>
In-Reply-To: <58cb370e0512230527l55810d0fif13d75f35723c1c3@mail.gmail.com>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> Driver OOPS-es on handling write barrier request (on finishing pre-flush)
> because REQ_STARTED flag is not set in __ide_end_request()
> but I don't see how this can happen, maybe something has changed
> in the block layer...  Does 2.6.14 work for you?
> 
> Does mounting ext3 with "barrier=0" option workaround the problem?
> 

Testing the workaround now. I'll know for sure if the system survives
for the next few days.

-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
