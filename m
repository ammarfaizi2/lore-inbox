Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262548AbUKQVHu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262548AbUKQVHu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 16:07:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262543AbUKQVFn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 16:05:43 -0500
Received: from v6.netlin.pl ([62.121.136.6]:37127 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S262548AbUKQVBD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 16:01:03 -0500
Message-ID: <419BBBB9.3030708@kde.org.uk>
Date: Wed, 17 Nov 2004 21:59:37 +0100
From: Grzegorz Piotr Jaskiewicz <gj@kde.org.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: pid_max madness
References: <419BB097.8030405@kde.org.uk> <20041117205024.GT3217@holomorphy.com>
In-Reply-To: <20041117205024.GT3217@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> On Wed, Nov 17, 2004 at 09:12:07PM +0100, Grzegorz Piotr Jaskiewicz wrote:
> 
>>Let's do:
>>#echo "-1" >/proc/sys/kernel/pid_max
>>#cat /proc/sys/kernel/pid_max
>>-1
>>#
>>Madness, isn't ?
>>I guess that isn't what author ment it to behave like.
>>Anyway, does it mean that after max unsigned value is reached pids are 
>>going to be negative in value ??
> 
> 
> Kernel version please?
all 2.6.x on intel86, this exact one is 2.6.9.
on 2.6.10-rc1-mm4 it doesn't change it anymore.

--
GJ

-rwxr-xr-x  1 root  5.89824e37 Oct 22  1990 /usr/bin/emacs
