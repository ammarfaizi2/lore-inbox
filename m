Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264650AbUEUWlE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264650AbUEUWlE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 18:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265083AbUEUWka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 18:40:30 -0400
Received: from zeus.kernel.org ([204.152.189.113]:5026 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S264650AbUEUWfM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 18:35:12 -0400
Message-ID: <40AE5D44.3020609@tmr.com>
Date: Fri, 21 May 2004 15:49:24 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
Newsgroups: mail.linux-kernel
To: "Jinu M." <jinum@esntechnologies.co.in>
CC: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org,
       "Surendra I." <surendrai@esntechnologies.co.in>
Subject: Re: protecting source code in 2.6
References: <1118873EE1755348B4812EA29C55A97222FD0D@esnmail.esntechnologies.co.in>
In-Reply-To: <1118873EE1755348B4812EA29C55A97222FD0D@esnmail.esntechnologies.co.in>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jinu M. wrote:
> Hi All,
> 
> We are developing a block device driver on linux-2.6.x kernel. We want
> to distribute our driver as sum of source code and librabry/object code.
> 
> We have divided the source code into two parts. The os interface module 
> and the device interface module. The os interface module (osint.c) has 
> all the os interface functions (init, exit, open, close, ioctl, request
> queue handling etc). The device interface module (devint.c) on the other
> hand has all the device interface functions (initialize device, read, 
> write etc), these don't use system calls or kernel APIs.
> 
> The device interface module is proprietary source and we don't intend
> to distribute it with source code on GPL license.

Thye approved way to do this is to write your own proprietary operating 
system to go with your proprietary driver, then you won't have to 
pretend to be open source.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
