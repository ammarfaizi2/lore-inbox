Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265516AbUAIEt4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 23:49:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265602AbUAIEt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 23:49:56 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:55990 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S265516AbUAIEty (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 23:49:54 -0500
Message-ID: <3FFE332E.7070307@osdl.org>
Date: Thu, 08 Jan 2004 20:50:54 -0800
From: Stephen Hemminger <shemminger@osdl.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: john moser <bluefoxicy@linux.net>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: spin_lock() and smp/multicall logic
References: <20040109003522.F1411E4B9@sitemail.everyone.net>
In-Reply-To: <20040109003522.F1411E4B9@sitemail.everyone.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john moser wrote:

> As always, CC all replies back to me.
> 
> I'm looking at include/linux/spinlock.h and I'm incredibly confused on something.

Buggy implementation of run_once deleted

> SO the two questions I'd like to address here are:
> 
> 1) What is the purpose of spin_lock()
> 2) Am I the first person to come up with this method of non-parallel execution
>   guarentee?

You invented an unsafe version of monitor using spin-locks.
Go read a on SMP operating systems.

"UNIX(R) Systems for Modern Architectures: Symmetric Multiprocessing and 
Caching for Kernel Programmers"




