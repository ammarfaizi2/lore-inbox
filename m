Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161179AbWI1V0Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161179AbWI1V0Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 17:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161182AbWI1V0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 17:26:25 -0400
Received: from gw.goop.org ([64.81.55.164]:6533 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1161179AbWI1V0Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 17:26:24 -0400
Message-ID: <451C3E09.6000400@goop.org>
Date: Thu, 28 Sep 2006 14:26:33 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-1.2689.fc6PAE: oops in ext3_clear_inode+0x52/0x8b
References: <451C33B2.5000007@goop.org> <20060928142313.8848cec9.akpm@osdl.org>
In-Reply-To: <20060928142313.8848cec9.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 756e6547 -> uneG.   Matches "GenuineIntel".
>
> That'll get written into a temporary page by the /proc/cpuinfo handler, so
> it might just be a use-uninitialised.
>   

I was compiling a kernel at the time, so it could have come from the 
kernel source.

> It's relatively common for that big inode LRU walk to wander off in the
> wrong direction and to start operating on random memory.
>
> IOW: don't know.  Something scribbled on memory somewhere.
>   

Yep, that was as far as I got...

    J
