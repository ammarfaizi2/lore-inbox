Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261192AbVCESoG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261192AbVCESoG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 13:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261256AbVCEShb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 13:37:31 -0500
Received: from mail1.skjellin.no ([80.239.42.67]:47827 "EHLO mx1.skjellin.no")
	by vger.kernel.org with ESMTP id S263333AbVCESbG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 13:31:06 -0500
Message-ID: <4229FAE8.6050107@tomt.net>
Date: Sat, 05 Mar 2005 19:31:04 +0100
From: Andre Tomt <andre@tomt.net>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: Adrian Bunk <bunk@stusta.de>, Chris Wright <chrisw@osdl.org>,
       torvalds@osdl.org, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFQ] Rules for accepting patches into the linux-releases tree
References: <20050304222146.GA1686@kroah.com> <20050305135917.GB6373@stusta.de> <20050305174055.GB13104@kroah.com>
In-Reply-To: <20050305174055.GB13104@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Sat, Mar 05, 2005 at 02:59:17PM +0100, Adrian Bunk wrote:
>>An example that doesn't fit:
>>
>>A patch of me to remove an unused function was accepted into 2.6.11 .
>>Today, someone mailed that there's an external GPL'ed module that uses 
>>this function.
>>
>>A patch to re-add this function as it was in 2.6.10 does not fulfill 
>>your criteria, but it is a low-risk way to fix a regression compared to 
>>2.6.10 .
> 
> 
> Yes, I wouldn't have a problem with adding this kind of fix.  Do others
> disagree?

Depends. Is Linus going to push it back into his tree? If it's just 
something like the remap_page_range going away, fix the the module 
instead, I'd say.
