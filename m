Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265163AbUFATir@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265163AbUFATir (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 15:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265164AbUFATir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 15:38:47 -0400
Received: from mta11.adelphia.net ([68.168.78.205]:23764 "EHLO
	mta11.adelphia.net") by vger.kernel.org with ESMTP id S265163AbUFATip
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 15:38:45 -0400
Message-ID: <40BCDB3E.3050705@nodivisions.com>
Date: Tue, 01 Jun 2004 15:38:38 -0400
From: Anthony DiSante <orders@nodivisions.com>
Reply-To: orders@nodivisions.com
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: swappiness ignored
References: <40B43B5F.8070208@nodivisions.com> <200405260940.i4Q9eJdS000767@81-2-122-30.bradfords.org.uk> <40BC2EFA.6090503@nodivisions.com> <200406011136.17055@WOLK>
In-Reply-To: <200406011136.17055@WOLK>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc-Christian Petersen wrote:
>>In the "why swap at all" thread, there was mention of the
>>/proc/sys/vm/swappiness tunable, and some people suggested echoing a zero
>>to there if you want to minimize/disable swap usage, or echoing a 100 to
>>maximize swap usage, etc.
>>But on my 2.6.5 system, I can echo a zero to there, then cat it back to
>>make sure... then 30 seconds later cat it again, and it's been changed to
>>something else (50, 60, 80something).
>>Is this supposed to be a value that can be manually adjusted, as some have
>>claimed, or is it something the kernel manages automatically?  I definitely
>>can't manually set it without having it overwritten shortly thereafter.
> 
> 
> I bet you have /proc/sys/vm/autoswappiness or the previous version of it 
> w/o /proc stuff.

Ah, yes, I do, and it's set to one.  So if I set that to zero, then the 
kernel won't automatically adjust /proc/sys/vm/swappiness?

-Anthony
http://nodivisions.com/
