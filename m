Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261641AbVCGGCv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261641AbVCGGCv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 01:02:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261644AbVCGGCv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 01:02:51 -0500
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:41349 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261641AbVCGGCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 01:02:46 -0500
Message-ID: <422BEE83.7020607@yahoo.com.au>
Date: Mon, 07 Mar 2005 17:02:43 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Prakash Punnoor <prakashp@arcor.de>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] nicksched for 2.6.11
References: <4225A020.5060001@yahoo.com.au> <42299D31.7020901@arcor.de>
In-Reply-To: <42299D31.7020901@arcor.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prakash Punnoor wrote:
> Nick Piggin schrieb:
> 
>>I've had a few queries about this, so by "popular" demand, I've
>>put my latest nicksched stuff here:
>>
>>www.kerneltrap.org/~npiggin/2.6.11-nicksched.gz
>>
>>It includes all the multiprocessor stuff that's in -mm, and also
>>my alternate scheduler policy.
> 
> 
> Hi,
> 
> just to make sure, is it still advised to renice X when using your scheduler?
> 

Yes it is. I have a hack in there that automatically renices any
binary starting with 'XF' to -10 for people who forget. So this
includes XFree86, though maybe it doesn't get the x.org server?

Nick

