Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264447AbTEaTnL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 15:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264459AbTEaTnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 15:43:11 -0400
Received: from fed1mtao02.cox.net ([68.6.19.243]:7617 "EHLO fed1mtao02.cox.net")
	by vger.kernel.org with ESMTP id S264447AbTEaTnK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 15:43:10 -0400
Message-ID: <3ED908F0.40901@cox.net>
Date: Sat, 31 May 2003 12:56:32 -0700
From: "Kevin P. Fleming" <kpfleming@cox.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4a) Gecko/20030401
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: LKML <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] include/linux/sysctl.h needs linux/compiler.h
References: <3ED8D5E4.6030107@cox.net> <20030531203242.B4202@infradead.org>
In-Reply-To: <20030531203242.B4202@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Sat, May 31, 2003 at 09:18:44AM -0700, Kevin P. Fleming wrote:
> 
>>Adding patch below solves the problem (yes, I know, userspace is not 
>>supposed to use kernel headers...)
> 
> 
> So why do you try it anyway?
> 

Until someone addresses this issue with a permanent fix, is there 
another choice? How can any userspace library that needs to issue 
syscalls compile against the existing sysctl.h without this change? I'm 
open to suggestions, obviously this was a quick and dirty fix (copied 
from other existing headers in .../linux already, which is certainly no 
excuse).

