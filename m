Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263221AbTKKDZh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 22:25:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264183AbTKKDZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 22:25:36 -0500
Received: from terminus.zytor.com ([63.209.29.3]:12469 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S263221AbTKKDZf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 22:25:35 -0500
Message-ID: <3FB05699.4050808@zytor.com>
Date: Mon, 10 Nov 2003 19:25:13 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030630
X-Accept-Language: en, sv, es, fr
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
CC: Andrea Arcangeli <andrea@suse.de>, Larry McVoy <lm@bitmover.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel.bkbits.net off the air
References: <Pine.LNX.4.44.0311101908540.2097-100000@bigblue.dev.mdolabs.com>
In-Reply-To: <Pine.LNX.4.44.0311101908540.2097-100000@bigblue.dev.mdolabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> On Mon, 10 Nov 2003, H. Peter Anvin wrote:
> 
> 
>>I guess the "best" solution is to use LVM atomic snapshots, and only
>>allow rsync off the atomic snapshot.  That way any particular rsync
>>session would always be consistent.  That's a *HUGE* amount of work,
>>though, and still doesn't solve the mirrors issue -- I don't control
>>what the mirrors run.  On the other hand, I don't know how many mirror
>>sites actually mirror /pub/scm since it's not a requirement.
> 
> 
> BTW, is rsync.kernel.org::pub/scm/linux/kernel/bkcvs currently being fed 
> with new data? I don't get any updates.
> 

It should be... I'll look at it in a bit.

	-hpa

