Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263946AbTDNXwo (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 19:52:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263968AbTDNXwo (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 19:52:44 -0400
Received: from dialup-139.156.221.203.acc50-nort-cbr.comindico.com.au ([203.221.156.139]:21252
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S263946AbTDNXwn (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 19:52:43 -0400
Message-ID: <3E9B4C6B.5020905@cyberone.com.au>
Date: Tue, 15 Apr 2003 10:03:55 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: Chuck Ebbert <76306.1226@compuserve.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Benefits from computing physical IDE disk geometry?
References: <200304141731_MC3-1-3462-2342@compuserve.com>
In-Reply-To: <200304141731_MC3-1-3462-2342@compuserve.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Chuck Ebbert wrote:

>Nick Piggin wrote:
>
>
>>There is (in AS) no cost function further than comparing distance
>>from the head. Closest forward seek wins.
>>
>
>
> The RAID1 code has its own scheduler that does similar things.  Why
>aren't they being integrated? (See raid1.c:read_balance())
>
If RAID1 can use the generic elevator then it should. I
guess it can't though.

