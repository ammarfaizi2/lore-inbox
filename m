Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261633AbVGKLOr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261633AbVGKLOr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 07:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261641AbVGKLOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 07:14:47 -0400
Received: from us401.activeby.net ([216.32.91.22]:43668 "EHLO
	us401.activeby.net") by vger.kernel.org with ESMTP id S261633AbVGKLOq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 07:14:46 -0400
Message-ID: <42D25491.5020207@active.by>
Date: Mon, 11 Jul 2005 14:14:25 +0300
From: Rommer <rommer@active.by>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: fork() & setpriority()
References: <42D250C1.6070604@active.by> <1121080075.3177.16.camel@laptopd505.fenrus.org>
In-Reply-To: <1121080075.3177.16.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=windows-1251; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - us401.activeby.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - active.by
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Arjan van de Ven wrote:
> On Mon, 2005-07-11 at 13:58 +0300, Rommer wrote:
> 
>>Hello,
>>
>>I have trouble with fork() and setpriority().
>>When priority of child process != priority of parent process
>>and used SIGCHLD handler.
>>See example.
> 
> 
> the example is buggy in that printf() isn't allowed in signal handlers
> btw...
> 

ok, you can remove printf() from SIGCHLD handler.

-- 
Best regards, Roman
