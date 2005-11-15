Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932361AbVKOEI0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361AbVKOEI0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 23:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932362AbVKOEI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 23:08:26 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:31443 "EHLO
	pd5mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S932361AbVKOEIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 23:08:25 -0500
Date: Mon, 14 Nov 2005 22:08:21 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [2.6 patch] i386: always use 4k stacks
In-reply-to: <5909m-5JB-5@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <43795F35.3050904@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <58XuN-29u-17@gated-at.bofh.it> <58XuN-29u-19@gated-at.bofh.it>
 <58XuN-29u-21@gated-at.bofh.it> <58XuN-29u-23@gated-at.bofh.it>
 <58XuN-29u-25@gated-at.bofh.it> <58XuN-29u-15@gated-at.bofh.it>
 <58YAt-3Fs-5@gated-at.bofh.it> <58ZGo-5ba-13@gated-at.bofh.it>
 <5909m-5JB-5@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff V. Merkey wrote:
> Why does the kernel need to be limited to 4K? for kernel preemption?

No, because it makes a whole lot of things simpler and more reliable if 
the kernel stack is only one page.

> 
> Someone needs to fix this. It's busted. It makes porting code between 
> Windows and Linux and other OS's difficult to support.

Ease of porting drivers written for other OSes to Linux is clearly not a 
high priority for the kernel community..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

