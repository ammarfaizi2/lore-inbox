Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261249AbVDBUOz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbVDBUOz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 15:14:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261252AbVDBUOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 15:14:55 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:56002 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261249AbVDBUOx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 15:14:53 -0500
Message-ID: <424EFD2A.6060305@colorfullife.com>
Date: Sat, 02 Apr 2005 22:14:34 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel stack size
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:

>I admit you really need to know what you're doing to use this method. If
>I believe that a kmalloc would be too expensive, then I use the locking
>of static variables. But each situation is different and I try to use
>the best method for the occasion.
>  
>
Have you benchmarked your own memory manager?
kmalloc(1024, GFP_KERNEL) is something like 17 instructions on i386 
uniprocessor.

--
    Manfred
