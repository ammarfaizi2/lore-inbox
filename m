Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266864AbUAXCgZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 21:36:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266858AbUAXCdD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 21:33:03 -0500
Received: from mail-03.iinet.net.au ([203.59.3.35]:8413 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S266851AbUAXCbj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 21:31:39 -0500
Message-ID: <4011D7AF.8030205@cyberone.com.au>
Date: Sat, 24 Jan 2004 13:25:51 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Eric <eric@cisu.net>
CC: linux-kernel@vger.kernel.org, davej@redhat.com
Subject: Re: Correct CPUs printout on boot.
References: <E1Ajuub-0000y1-00@hardwired> <200401231703.54127.eric@cisu.net>
In-Reply-To: <200401231703.54127.eric@cisu.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Eric wrote:

>On Friday 23 January 2004 12:35 am, davej@redhat.com wrote:
>
>>This currently prints out the maximum number of CPUs the
>>kernel is configured to support, instead of the actual
>>number that the kernel brought up. Which results in odd
>>displays that look like you have more CPUs than you do.
>>
>
>Why do you have to declare a new variable? Can't you just do this? i is 
>already counting how many cpu's we've brought up and its of the same type j.
>

CPU numbering is allowed to be sparse. Besides, i still
counts up to NR_CPUS even if CPU numbering isn't sparse.


