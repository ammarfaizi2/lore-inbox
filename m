Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751438AbWGMFr7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438AbWGMFr7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 01:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751442AbWGMFr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 01:47:58 -0400
Received: from terminus.zytor.com ([192.83.249.54]:14041 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751438AbWGMFr6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 01:47:58 -0400
Message-ID: <44B5DD41.90705@zytor.com>
Date: Wed, 12 Jul 2006 22:42:25 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Albert Cahalan <acahalan@gmail.com>
CC: ak@suse.de, tytso@mit.edu, ebiederm@xmission.com, drepper@redhat.com,
       arjan@infradead.org, rdunlap@xenotime.net, akpm@osdl.org,
       linux-kernel@vger.kernel.org, libc-alpha@sourceware.org
Subject: Re: [PATCH] Use uname not sysctl to get the kernel revision
References: <787b0d920607122200m4785f7ddmddf40c079a7460cb@mail.gmail.com>
In-Reply-To: <787b0d920607122200m4785f7ddmddf40c079a7460cb@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan wrote:
>>
>> The numerical namespace for sysctl is unsalvagable imho. e.g.
>> distributions regularly break it because there is no central
>> repository of numbers so it's not very usable anyways in practice.
> 
> Huh? How exactly is this different from system call numbers,
> ioctl numbers, fcntl numbers, ptrace command numbers, and every
> other part of the Linux ABI?
> 

Mostly because some branches of the sysctl tree have dynamic content 
which is hard to marshal into a numeric form.

	-hpa
