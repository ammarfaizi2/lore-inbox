Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261664AbUK2KwQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261664AbUK2KwQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 05:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261656AbUK2KuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 05:50:25 -0500
Received: from out006pub.verizon.net ([206.46.170.106]:7386 "EHLO
	out006.verizon.net") by vger.kernel.org with ESMTP id S261662AbUK2KrY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 05:47:24 -0500
Message-ID: <41AAFE4E.7010308@verizon.net>
Date: Mon, 29 Nov 2004 05:47:42 -0500
From: Jim Nelson <james4765@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Wichert Akkerman <wichert@wiggy.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Question about /dev/mem and /dev/kmem
References: <41AA9E26.4070105@verizon.net> <20041129093937.GN31995@wiggy.net>
In-Reply-To: <20041129093937.GN31995@wiggy.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out006.verizon.net from [209.158.220.243] at Mon, 29 Nov 2004 04:47:19 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wichert Akkerman wrote:
> Previously Jim Nelson wrote:
> 
>>I was looking at some articles about rootkits on monolithic kernels, and 
>>had a thought.  Would a kernel config option to disable write access to 
>>/dev/mem and /dev/kmem be a workable idea?
> 
> 
> Yes, but not a very useful one since it is an incomplete solution. You
> can easily do something better using /proc/kernel/cap-bound

Isn't that /proc/sys/kernel/cap-bound?

> (like writing 0xFFFCFFFF into it).
> 

And what stops an attacker who's already gained root from doing a "cat "0" > 
/proc/sys/kernel/cap-bound" ?

> Wichert.
> 

