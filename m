Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263913AbTDYXEm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 19:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264542AbTDYXEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 19:04:42 -0400
Received: from pheriche.sun.com ([192.18.98.34]:24283 "EHLO pheriche.sun.com")
	by vger.kernel.org with ESMTP id S263913AbTDYXEe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 19:04:34 -0400
Message-ID: <3EA9C104.9080300@sun.com>
Date: Fri, 25 Apr 2003 16:13:08 -0700
From: Hui Huang <hui.huang@sun.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
Subject: Re: TASK_UNMAPPED_BASE & stack location
References: <20030425220018$6219@gated-at.bofh.it>	<20030425220018$76b1@gated-at.bofh.it>	<20030425225007$3fae@gated-at.bofh.it> <m3n0ie422e.fsf@averell.firstfloor.org>
In-Reply-To: <m3n0ie422e.fsf@averell.firstfloor.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> 
>>I've moved PAGE_OFFSET around a lot (which moves the stack, as you say). 
>>Haven't seen it break anything yet ... IMHO it was broken anyway if this
>>hurts it. Obviously not something one could do in a stable kernel series,
>>but 2.5 seems like a perfect time for it to me ... unless I'm missing some
>>glibc / linker thing, it seems like a simple change.
> 
> 
> It at least broke Sun Java.
> 

That has been fixed in latest JDK.

