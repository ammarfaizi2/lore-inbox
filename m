Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261597AbUC0FrR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 00:47:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261462AbUC0FrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 00:47:17 -0500
Received: from opersys.com ([64.40.108.71]:19215 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261602AbUC0FrQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 00:47:16 -0500
Message-ID: <406516C7.40705@opersys.com>
Date: Sat, 27 Mar 2004 00:53:11 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: khandelw@cs.fsu.edu
CC: linux-kernel@vger.kernel.org
Subject: Re: logging in kernel
References: <1080339875.8f2cd36818efd@system.cs.fsu.edu>
In-Reply-To: <1080339875.8f2cd36818efd@system.cs.fsu.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


khandelw@cs.fsu.edu wrote:
> Hello,
>     I am a graudate student at Florida State University. My friends and my self
> are planning to implement a kernel logger for linux kernel (real-time systems).
> We are new to linux kernel programming and we have not done kernel programming.
>     We believe right now most of the system are using printk. We want to write a
> tool which can be used for debugging as well as logging of data in the future.
> Following are the things that we have in mind so far.
> 
> 1. Implement the logging daemon or the server as a periodic task in the
> real-time system.
> 2. Have an api which looks similar to printk
> 3. Have an option to specify the write the network card or console or a
> dedicated device.
> 4. Use it for checkpointing in distributed system.

There have been quite a few things done in this area already. For starters,
you may want to take a look at the Linux Trace Toolkit and the underlying
mechanism, relayfs:
http://www.opersys.com/ltt/index.html
http://www.opersys.com/relayfs/index.html

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546

