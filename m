Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261355AbULHUgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261355AbULHUgK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 15:36:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261349AbULHUe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 15:34:59 -0500
Received: from mail.dif.dk ([193.138.115.101]:13212 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261355AbULHUes (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 15:34:48 -0500
Message-ID: <41B767CC.8000109@dif.dk>
Date: Wed, 08 Dec 2004 21:45:00 +0100
From: Jesper Juhl <juhl-lkml@dif.dk>
Organization: DIF
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Limiting program swap
References: <cp7iqj$57n$1@gatekeeper.tmr.com>
In-Reply-To: <cp7iqj$57n$1@gatekeeper.tmr.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:
> I have several machine of various memory sizes which suffer from really 
> poor performance when doing backups. This appears to be because all the 
> programs other than the backup quickly get swapped to make room for i/o 
> buffers.
> 
> Is there some standard portable way to prevent this, either by reserving 
> some memory for programs which will not get swapped regardless of i/o 
> pressure, or alternatively limiting the total memory used for i/o 
> buffers, dcache, and similar things?
> 

I'm wondering if turning the /proc/sys/vm/swappiness knob would help, 
but I'll honestly admit that I don't know.

-- 
Jesper Juhl
