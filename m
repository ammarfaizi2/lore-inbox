Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262706AbVCJRSV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262706AbVCJRSV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 12:18:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262192AbVCJRQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 12:16:05 -0500
Received: from vms044pub.verizon.net ([206.46.252.44]:19591 "EHLO
	vms044pub.verizon.net") by vger.kernel.org with ESMTP
	id S262677AbVCJRMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 12:12:52 -0500
Date: Thu, 10 Mar 2005 12:12:51 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: minor 2.6.11-bk6 config issue or user error
In-reply-to: <423069EC.8070207@arcor.de>
To: linux-kernel@vger.kernel.org
Cc: Prakash Punnoor <prakashp@arcor.de>
Reply-to: gene.heskett@verizon.net
Message-id: <200503101212.51466.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <423069EC.8070207@arcor.de>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 March 2005 10:38, Prakash Punnoor wrote:
>Hi,
>
>I went from bk4 to bk6. After patching i just typed make to
> recompile (as I thought this would be enough). But it errored out
> because CONFIG_BASE_SMALL wasn't defined. So I did make menuconfig
> and saved my config again and now it compiles through.
>
>Is it needed to run make oldconfig or make menuconfig and save
> before kernel upgrade? I thought make oldconfig is run
> automatically on make?
>
>--
>Prakash Punnoor
>
I believe thats mistaken Prakash.  One should do a make oldconfig 
after applying any patch, or when moving an existing .config from an 
older version's tree to the new tree you are building.  Its all part 
of my scripts so I don't forget.

>formerly known as Prakash K. Cheemplavam

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.34% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
