Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262691AbUBZFiP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 00:38:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262693AbUBZFiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 00:38:15 -0500
Received: from smtp810.mail.sc5.yahoo.com ([66.163.170.80]:21671 "HELO
	smtp810.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262691AbUBZFiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 00:38:14 -0500
Message-ID: <403D8643.6000909@uchicago.edu>
Date: Wed, 25 Feb 2004 23:38:11 -0600
From: Ryan Reich <ryanr@uchicago.edu>
User-Agent: Mozilla Thunderbird 0.5+ (X11/20040211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: glauber@mpcnet.com.br, linux-kernel@vger.kernel.org
Subject: Re: help in sysfs
References: <1tltA-427-3@gated-at.bofh.it>
In-Reply-To: <1tltA-427-3@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

glauber@mpcnet.com.br wrote:
> Sorry if I'm being redundant
> 
> I spent a lot of time looking for it, and did 
> not find, so I came here for help
> Perhaps anyone can help me, or point me to the 
> right place to ask
> 
> I did not yet fully understand how sysfs works, 
> and so, any docs would be welcome
> 
> My main problem is: 
> I'm trying to use udev, but some devices for
> drivers that are compiled in the kernel does
> not appear in. I searched for entries 
> representing then in /sys, and found no one
> Specifically, no pts is found there
> in my .config, I have CONFIG_UNIX98_PTYS=y
> What can I do in order to solve this problem?

Have you mounted /dev/pts?

$ mount -t devpts devpts /dev/pts

(Of course, /dev/pts needs to exist first).  They should appear when you 
connect to a terminal.

Also, not all the supported devices have yet been ported to sysfs.

-- 
Ryan Reich
ryanr@uchicago.edu
