Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262640AbVA0Plx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262640AbVA0Plx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 10:41:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262645AbVA0Plx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 10:41:53 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:30604 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S262640AbVA0Plq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 10:41:46 -0500
Message-ID: <41F90C85.5090705@tmr.com>
Date: Thu, 27 Jan 2005 10:45:09 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sytse Wielinga <s.b.wielinga@student.utwente.nl>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc2-mm1: fuse patch needs new libs
References: <20050124021516.5d1ee686.akpm@osdl.org><20050124021516.5d1ee686.akpm@osdl.org> <20050125000339.GA610@speedy.student.utwente.nl>
In-Reply-To: <20050125000339.GA610@speedy.student.utwente.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sytse Wielinga wrote:
> Hi Andrew,
> 
> On Mon, Jan 24, 2005 at 02:15:16AM -0800, Andrew Morton wrote:
> 
>>fuse-transfer-readdir-data-through-device.patch
>>  fuse: transfer readdir data through device
> 
> It is great that this is fixed, don't remove it, but it does require the fuse
> libs to be updated at the same time, or opening dirs for listings will break
> like this:
> 
> open(".", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY) = -1 ENOSYS (Function
> not implemented)
> 
> As I personally like for my ls to keep on working, and I assume others will,
> too, I would appreciate it if you could add a warning to your announcements the
> following one or two weeks or so, so that people can remove this patch if they
> don't want to update their libs.

By any chance would this also break perl programs which readdir?

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
