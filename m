Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265958AbUFOUrq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265958AbUFOUrq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 16:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265947AbUFOUrq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 16:47:46 -0400
Received: from vhost12.digitarus.com ([194.242.150.12]:19850 "EHLO
	vhost12.digitarus.com") by vger.kernel.org with ESMTP
	id S265961AbUFOUrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 16:47:16 -0400
X-ClientAddr: 212.126.40.83
Message-ID: <40CF6053.3020105@wiggly.org>
Date: Tue, 15 Jun 2004 21:47:15 +0100
From: Nigel Rantor <wiggly@wiggly.org>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: cdrom ripping / dropping to dingle frame dma
References: <40CF594C.30109@wiggly.org> <20040615203828.GA12504@suse.de>
In-Reply-To: <20040615203828.GA12504@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Digitarus-vhost12-MailScanner-Information: Please contact Digitarus for more information
X-Digitarus-vhost12-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> It did not, and it didn't fix the issue completely. My plan is to add a
> counter just checking if we succeeded doing some dma ripping already,
> in which case there's no point to falling back to lesser methods. That
> should be way more reliable than checking sense and making up our on
> rules based on that.
> 
> I'll get a patch out tomorrow.

Cool, thanks for the reply. I'm quite happy to go to 2.6.7 if that's 
what you'll be patching against.

Are you still looking for people who can reproduce this problem? If so 
I'll try and find a couple of the CDs that I have that kill ripping now 
on this kernel before applying any patches you come up with.

Regards,

   N
