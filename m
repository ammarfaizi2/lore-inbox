Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261287AbULTJVe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261287AbULTJVe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 04:21:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261327AbULTJVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 04:21:34 -0500
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:44409 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261287AbULTJV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 04:21:29 -0500
Message-ID: <41C69993.5000704@yahoo.com.au>
Date: Mon, 20 Dec 2004 20:21:23 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Zhenyu Wu <y030729@njupt.edu.cn>
CC: linux-kernel@vger.kernel.org
Subject: Re: About kernel panic!
References: <303535658.02371@njupt.edu.cn>
In-Reply-To: <303535658.02371@njupt.edu.cn>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zhenyu Wu wrote:
> Hello, Everyone,
> 
> I think i have met lots of troubles when i am programming in the kernel, so, i
> want to get
> some help.
> 
> One of my troubles is that, sometimes, the program can work well, but sometimes,
> there are
> kernel panics. So, does someone else meet such questions, what is the major
> reasons? From the
> indication of the log messages, i can find the messages on allocting the memory, i
> remember, 
> i use the kmalloc to do it, but is there something wrong? 
> 

Yes, there is something wrong with your kernel code. The oops will
tell you what went wrong.

Reading Documentation/oops-tracing.txt is a good start.

Nick
