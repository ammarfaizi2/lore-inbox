Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932535AbWCVUKf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932535AbWCVUKf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 15:10:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932539AbWCVUKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 15:10:35 -0500
Received: from rutherford.zen.co.uk ([212.23.3.142]:16518 "EHLO
	rutherford.zen.co.uk") by vger.kernel.org with ESMTP
	id S932536AbWCVUKd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 15:10:33 -0500
Message-ID: <4421AF29.3070405@cantab.net>
Date: Wed, 22 Mar 2006 20:10:17 +0000
From: David Vrabel <dvrabel@cantab.net>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: ucb1x00 audio & zaurus touchscreen
References: <20060322122052.GN14075@elf.ucw.cz>
In-Reply-To: <20060322122052.GN14075@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-Rutherford-IP: [82.70.146.41]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
> First, I'd like to ask: what is status of ucb1x00 audio in 2.6? I do
> have .c file here, but do not have corresponding header files...
> 
> Then, I'd like to announce that I finally got touchscreen to somehow
> work. Patch is very ugly and adds filtering into kernel (no-no), but
> does the trick, and can even coexist with battery reading code. [Don't
> bother commenting on style of this patch, it is for ilustration, I'd
> not be crazy enough to try to push it.]

I also have a brown-paper-bag hack to this driver that:

   a) makes it work without interrupts
   b) improves the interactive performance
   c) makes it work on non-arm.

I'll post the patch tomorrow when I'm back at work.

David Vrabel
