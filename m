Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263102AbUK0AiR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263102AbUK0AiR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 19:38:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263085AbUK0AfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 19:35:19 -0500
Received: from outmail1.freedom2surf.net ([194.106.33.237]:21131 "EHLO
	outmail.freedom2surf.net") by vger.kernel.org with ESMTP
	id S263107AbUK0Aed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 19:34:33 -0500
Message-ID: <41A7CB88.8020802@f2s.com>
Date: Sat, 27 Nov 2004 00:34:16 +0000
From: Ian Molton <spyro@f2s.com>
Organization: The Dragon Roost
User-Agent: Mozilla Thunderbird 0.8 (X11/20040929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kill unused call_irq()
References: <20041114104627.GA32234@lst.de> <20041120173559.H13550@flint.arm.linux.org.uk>
In-Reply-To: <20041120173559.H13550@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Sun, Nov 14, 2004 at 11:46:27AM +0100, Christoph Hellwig wrote:
> 
>>These routine in arm and arm26 is unused (in fact not even compiled).
>>
>>Inatead of converting it to local_softirq_pending I'd suggest just
>>removing it as below as it's been there totally unused for a long time.
> 
> 
> I've applied the ARM bit... Ian - please handle ARM26 bit below.  Thanks.

Applied. thanks.

(wow, arm26 is a mes right now - only 3 minor versions and it needed a 
ton of fixes. I gotta push some  of my patch(es) mainline-ward...)

