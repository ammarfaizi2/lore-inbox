Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261585AbTIYQ4R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 12:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261473AbTIYQy4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 12:54:56 -0400
Received: from 64-60-248-67.cust.telepacific.net ([64.60.248.67]:60177 "EHLO
	mx.rackable.com") by vger.kernel.org with ESMTP id S261647AbTIYQx3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 12:53:29 -0400
Message-ID: <3F731BE2.6020300@rackable.com>
Date: Thu, 25 Sep 2003 09:46:26 -0700
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bradley Chapman <kakadu_croc@yahoo.com>
CC: Paolo Dovera <pdovera@bmind.it>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test broke RPM 4.2 on Red Hat 9 in a VERY weird way
References: <20030925163654.52439.qmail@web40902.mail.yahoo.com>
In-Reply-To: <20030925163654.52439.qmail@web40902.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Sep 2003 16:53:25.0332 (UTC) FILETIME=[8943D940:01C38385]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bradley Chapman wrote:
> Mr. Dovera,
> 
> --- Paolo Dovera <pdovera@bmind.it> wrote:
> 
>>Hi, try this:
>>
>>export LD_ASSUME_KERNEL=2.4.1
>>
>>before run rpm command, this works fine on my RH9
> 
> 
> Hmmm. What version of glibc do you have? I have glibc 2.3.2 installed and
> I get the same error with LD_ASSUME_KERNEL=2.4.1
> 
> I tried LD_ASSUME_KERNEL=2.4.22, since everything is good under 2.4, but that
> didn't help either. Another guy said to check the archives, which I did, but
> I don't know what to search for.


   Are you doing LD_ASSUME_KERNEL=2.4.1 on the same line as the rpm command?

This should work:
LD_ASSUME_KERNEL=2.4.1 rpm -qa

This shouldn't:
LD_ASSUME_KERNEL=2.4.1
rpm -qa

-- 
Once you have their hardware. Never give it back.
(The First Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>

