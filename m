Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbUCIGGo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 01:06:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261377AbUCIGGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 01:06:44 -0500
Received: from mail-10.iinet.net.au ([203.59.3.42]:24733 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261321AbUCIGGn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 01:06:43 -0500
Message-ID: <404D5EED.80105@cyberone.com.au>
Date: Tue, 09 Mar 2004 17:06:37 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [RFC][PATCH 4/4] vm-mapped-x-active-lists
References: <404D56D8.2000008@cyberone.com.au> <404D5784.9080004@cyberone.com.au> <404D5A6F.4070300@matchmail.com>
In-Reply-To: <404D5A6F.4070300@matchmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Mike Fedyk wrote:

> Nick Piggin wrote:
>
>>
>>
>> ------------------------------------------------------------------------
>>
>>
>> Split the active list into mapped and unmapped pages.
>
>
> This looks similar to Rik's Active and Active-anon lists in 2.4-rmap.
>

Oh? I haven't looked at 2.4-rmap for a while. Well I guess that gives
it more credibility, thanks.

> Also, how does this interact with Andrea's VM work?
>

Not sure to be honest, I haven't looked at it :\. I'm not really
sure if the rmap mitigation direction is just a holdover until
page clustering or intended as a permanent feature...

Either way, I trust its proponents will take the onus for regressions.

