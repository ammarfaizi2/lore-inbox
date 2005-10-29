Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932700AbVJ2WdP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932700AbVJ2WdP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 18:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932705AbVJ2WdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 18:33:15 -0400
Received: from mail.dvmed.net ([216.237.124.58]:44422 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932700AbVJ2WdO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 18:33:14 -0400
Message-ID: <4363F8A6.2050501@pobox.com>
Date: Sat, 29 Oct 2005 18:33:10 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Deepak Saxena <dsaxena@plexity.net>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, tony@atomide.com,
       "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patch 0/5] HW RNG cleanup & new drivers
References: <20051029191229.562454000@omelas> <4363F31F.2040303@pobox.com> <Pine.LNX.4.64.0510291524050.3348@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510291524050.3348@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sat, 29 Oct 2005, Jeff Garzik wrote:
> 
>>I would prefer to let this live in -mm at least for a little while.
>>Confirmation from AMD, Intel and VIA owners would be really nice, too. AMD and
>>Intel might be a little bit hard to find.  I think Peter Anvin had an Intel
>>ICH w/ RNG at one time...
> 
> 
> I'm just wondering why via/amd/intel end up being one driver. It would 
> seem to be more sensible to have separate drivers for them, since they 
> have no real overlap..

No real reason other than historical.  Split up would be my preference.

	Jeff


