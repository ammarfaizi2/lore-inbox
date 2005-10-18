Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751427AbVJRAXH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427AbVJRAXH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 20:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbVJRAXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 20:23:07 -0400
Received: from terminus.zytor.com ([192.83.249.54]:6356 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751427AbVJRAXG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 20:23:06 -0400
Message-ID: <43544063.4040602@zytor.com>
Date: Mon, 17 Oct 2005 17:22:59 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC] RNG rewrite...
References: <20051015043120.GA5946@plexity.net> <4350DCB1.7010201@pobox.com> <20051016005341.GB5946@plexity.net> <dj1bb5$riu$1@terminus.zytor.com> <43543331.6030603@pobox.com>
In-Reply-To: <43543331.6030603@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
>> MSR instructions cannot execute out of userspace, but the MSR driver
>> might be possible to use.  It's usually quite slow, however.
> 
> MSRs are used for setup, not for actual data.
> 
> Intel:  magic MMIO address (readb)
> AMD:    magic PIO address (inl)
> VIA:    CPU instruction ('xstore')
> 

For setup, the MSR driver is fine.

	-hpa
