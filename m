Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262747AbVFWTiN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262747AbVFWTiN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 15:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262745AbVFWTdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 15:33:09 -0400
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:16138 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id S262705AbVFWTaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 15:30:25 -0400
Message-ID: <42BB0DBE.3070003@superbug.demon.co.uk>
Date: Thu, 23 Jun 2005 20:30:06 +0100
From: James Courtier-Dutton <James@superbug.demon.co.uk>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050416)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Subject: Re: 2.6.12-rc6-mm1 oops on startup.
References: <42B46C18.2030101@superbug.demon.co.uk> <20050621235144.15fc55c6.akpm@osdl.org>
In-Reply-To: <20050621235144.15fc55c6.akpm@osdl.org>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> James Courtier-Dutton <James@superbug.demon.co.uk> wrote:
> 
>>I have used the kernel.org normal kernel, and it compiles and boots fine.
>> I then use exactly the same .config file for the 2.6.12-rc6-mm1 and it
>> fails to boot.
> 
> 
> It's due to the fork notifier code.  Set CONFIG_FORK_CONNECTOR=n and you
> should be OK.
> 

2.6.12-mm1 fails just like previous versions.

Setting "CONFIG_FORK_CONNECTOR=n" permitted me to boot the kernel, thank
you.

James


