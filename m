Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965020AbWDHQ2n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965020AbWDHQ2n (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 12:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965022AbWDHQ2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 12:28:42 -0400
Received: from anchor-post-31.mail.demon.net ([194.217.242.89]:14348 "EHLO
	anchor-post-31.mail.demon.net") by vger.kernel.org with ESMTP
	id S965021AbWDHQ2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 12:28:42 -0400
Message-ID: <4437E4B7.40208@superbug.co.uk>
Date: Sat, 08 Apr 2006 17:28:39 +0100
From: James Courtier-Dutton <James@superbug.co.uk>
User-Agent: Mail/News 1.5 (X11/20060405)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Black box flight recorder for Linux
References: <5ZjEd-4ym-37@gated-at.bofh.it> <5ZlZk-7VF-13@gated-at.bofh.it> <4437C335.30107@shaw.ca> <200604080917.39562.ak@suse.de>
In-Reply-To: <200604080917.39562.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Saturday 08 April 2006 16:05, Robert Hancock wrote:
>> Andi Kleen wrote:
>>> James Courtier-Dutton <James@superbug.co.uk> writes:
>>>> Now, the question I have is, if I write values to RAM, do any of those
>>>> values survive a reset?
>>> They don't generally.
>>>
>>> Some people used to write the oopses into video memory, but that
>>> is not portable.
>> I wouldn't think most BIOSes these days would bother to clear system RAM
>> on a reboot. Certainly Microsoft was encouraging vendors not to do this
>> because it slowed down system boot time.to
> 
> Reset button is like a cold boot and it generally ends up with cleared 
> RAM.
> 
> -Andi

Thank you. That saved me 30mins hacking. :-)

