Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751489AbWGYS4i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489AbWGYS4i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 14:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbWGYS4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 14:56:38 -0400
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:1453 "EHLO
	mail-in-08.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751489AbWGYS4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 14:56:38 -0400
In-Reply-To: <20060725182833.GE4608@hmsreliant.homelinux.net>
References: <20060725174100.GA4608@hmsreliant.homelinux.net> <03BCDC7F-13D9-42FC-86FC-30C76FD3B3B8@kernel.crashing.org> <20060725182833.GE4608@hmsreliant.homelinux.net>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <857D7DE9-D1F6-4A66-91F2-BC4D9044D42C@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, a.zummo@towertech.it, jg@freedesktop.org
Content-Transfer-Encoding: 7bit
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] RTC: Add mmap method to rtc character driver
Date: Tue, 25 Jul 2006 20:56:14 +0200
To: Neil Horman <nhorman@tuxdriver.com>
X-Mailer: Apple Mail (2.750)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Similar functionality is already available via VDSO on
>> platforms that support it (currently PowerPC and AMD64?) --
>> seems like a better way forward.
>>
> In general I agree, but that only works if you operate on a  
> platform that
> supports virtual syscalls, and has vdso configured.

That's why I said "a better way forward", not "this already
works everywhere".

> I'm not overly familiar
> with vdso, but I didn't think vdso could be supported on all  
> platforms/arches.

Oh?  Which can not, and why?


Segher

