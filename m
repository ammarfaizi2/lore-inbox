Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262286AbVFWXLd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262286AbVFWXLd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 19:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262559AbVFWXLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 19:11:32 -0400
Received: from mail.dvmed.net ([216.237.124.58]:34749 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262286AbVFWXKt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 19:10:49 -0400
Message-ID: <42BB4172.5000904@pobox.com>
Date: Thu, 23 Jun 2005 19:10:42 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: David Lang <david.lang@digitalinsight.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Netdev List <netdev@vger.kernel.org>
Subject: Re: [git patch] urgent e1000 fix
References: <42BA7FB5.5020804@pobox.com> <Pine.LNX.4.62.0506231402340.18154@qynat.qvtvafvgr.pbz> <42BB2749.1020209@pobox.com> <Pine.LNX.4.58.0506231506510.11175@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506231506510.11175@ppc970.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Thu, 23 Jun 2005, Jeff Garzik wrote:
> 
>>It's probably the whitespace thing that Linus's git-apply gadget was 
>>complaining about.
>>
>>I'm terribly surprising, though, since my patch(1) applied the diff just 
>>fine.
> 
> 
> I could easily make git-apply accept empty lines as if they had a single 
> space on it. What I find surprising is that "patch" allows that kind of 
> whitespace corruption by default, and silently. Usually you have to give 
> it the "-l" flag to make it ignore whitespace differences..


patch(1) is a huge collection of heuristics like this, even without 
'-l', so I'm not surprised that it worked.

Does git-apply support patches with "fuzz", out of curiosity?

	Jeff


