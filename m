Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267507AbUHJSA1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267507AbUHJSA1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 14:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267612AbUHJR5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 13:57:16 -0400
Received: from 209-128-98-078.bayarea.net ([209.128.98.78]:22946 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S267588AbUHJRwP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 13:52:15 -0400
Message-ID: <41190B1F.4020202@zytor.com>
Date: Tue, 10 Aug 2004 17:51:27 +0000
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7) Gecko/20040608
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: BUG: bsd pts now climbs continuously
References: <Pine.LNX.4.30.0408091609100.31211-200000@link>	 <1092086245.14770.2.camel@localhost.localdomain>	 <cf9hm5$tsu$1@terminus.zytor.com> <1092137890.16939.8.camel@localhost.localdomain>
In-Reply-To: <1092137890.16939.8.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Maw, 2004-08-10 at 05:07, H. Peter Anvin wrote:
> 
>>>ssh breaks at 9999 which is fun too. It runs out of buffer space
>>>although because its been properly coded it doesn't overrun it just
>>>starts corrupting utmp
>>>
>>
>>This I believe is a glibc bug, and really needs to be fixed.
>>Unfortunately glibc's handling of utmp is just incredibly broken.
> 
> 
> How remarkable given the snprintf line in question is in the sshd
> source code.
> 

OK, that wasn't the bug I was thinking about, then :)

I was referring to the "line id" stuff in utmp, which really seems too 
broken to live.
