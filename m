Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262531AbULDGQH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262531AbULDGQH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 01:16:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262534AbULDGQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 01:16:07 -0500
Received: from mail.ccdaust.com.au ([203.29.88.42]:57914 "EHLO
	gateway.ccdaust.com.au") by vger.kernel.org with ESMTP
	id S262531AbULDGQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 01:16:04 -0500
Message-ID: <41B15615.3020001@wasp.net.au>
Date: Sat, 04 Dec 2004 10:15:49 +0400
From: Brad Campbell <brad@wasp.net.au>
User-Agent: Mozilla Thunderbird 0.6+ (X11/20041109)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dieter Stueken <stueken@conterra.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: libata-dev queue updated
References: <41B07FC3.9040506@conterra.de>
In-Reply-To: <41B07FC3.9040506@conterra.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dieter Stueken wrote:
>> * ATA passthru (read: SMART support)
> 
> 
> is it still unsafe to use passthru concurrently
> to normal disk I/O, as stated earlier?

It appears to be safe with a UP machine at the moment. (Read as: I have been beating it hard for 
over a month with no issues.) SMP is known to have a race which may not be good.



-- 
Brad
                    /"\
Save the Forests   \ /     ASCII RIBBON CAMPAIGN
Burn a Greenie.     X      AGAINST HTML MAIL
                    / \
