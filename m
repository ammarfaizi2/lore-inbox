Return-Path: <linux-kernel-owner+w=401wt.eu-S1422745AbXAHUwI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422745AbXAHUwI (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 15:52:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422740AbXAHUwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 15:52:08 -0500
Received: from zcars04e.nortel.com ([47.129.242.56]:34737 "EHLO
	zcars04e.nortel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422745AbXAHUwH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 15:52:07 -0500
Message-ID: <45A2AED3.8070609@nortel.com>
Date: Mon, 08 Jan 2007 14:51:31 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050427 Red Hat/1.7.7-1.1.3.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: dean gaudet <dean@arctic.org>, "H. Peter Anvin" <hpa@zytor.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] All Transmeta CPUs have constant TSCs
References: <200701050148.l051mHGM005275@terminus.zytor.com> <Pine.LNX.4.61.0701051524440.7813@yvahk01.tjqt.qr> <Pine.LNX.4.64.0701072358010.26307@twinlark.arctic.org> <Pine.LNX.4.61.0701082118370.23737@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0701082118370.23737@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Jan 2007 20:51:36.0171 (UTC) FILETIME=[C96293B0:01C73366]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
> On Jan 8 2007 00:02, dean gaudet wrote:

>>transmeta decided years before intel and amd that a constant rate tsc 
>>(unaffected by P-state) was the only sane choice.  on transmeta cpus the 
>>tsc increments at the maximum cpu frequency no matter what the P-state 
>>(and no matter what longrun is doing behind the kernel's back).

> Well it defeats the purpose of TSC. I mean, they could have kept the "TSC" and
> instead added a second TSC ticker, constant_tsc.

Given that the name is "time stamp counter" then it makes sense to me to 
have a constant frequency.

For performance monitoring it would be useful to have a "cpu cycle 
counter" that counts clock cycles, and varies (and possibly stops) with 
the cpu itself.

Chris



