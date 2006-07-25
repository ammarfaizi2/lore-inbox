Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030253AbWGYXaH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030253AbWGYXaH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 19:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030255AbWGYXaH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 19:30:07 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:46247 "EHLO
	mail-in-04.arcor-online.net") by vger.kernel.org with ESMTP
	id S1030253AbWGYXaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 19:30:05 -0400
In-Reply-To: <20060725222547.GA3973@localhost.localdomain>
References: <03BCDC7F-13D9-42FC-86FC-30C76FD3B3B8@kernel.crashing.org> <20060725182833.GE4608@hmsreliant.homelinux.net> <44C66C91.8090700@zytor.com> <20060725192138.GI4608@hmsreliant.homelinux.net> <F09D8005-BD93-4348-9FD1-0FA5D8D096F1@kernel.crashing.org> <20060725194733.GJ4608@hmsreliant.homelinux.net> <21d7e9970607251304n5681bf44gc751c21fd79be99d@mail.gmail.com> <44C67E1A.7050105@zytor.com> <20060725204736.GK4608@hmsreliant.homelinux.net> <44C6842C.8020501@zytor.com> <20060725222547.GA3973@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <70FED39F-E2DF-48C8-B401-97F8813B988E@kernel.crashing.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Dave Airlie <airlied@gmail.com>,
       linux-kernel@vger.kernel.org, a.zummo@towertech.it, jg@freedesktop.org
Content-Transfer-Encoding: 7bit
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] RTC: Add mmap method to rtc character driver
Date: Wed, 26 Jul 2006 01:29:25 +0200
To: Neil Horman <nhorman@tuxdriver.com>
X-Mailer: Apple Mail (2.750)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes, but if its in trade for something thats being used currently  
> which hurts
> more (case in point being the X server), using this solution is a  
> net gain.

...in the short term.

> I'm not arguing with you that adding a low res gettimeofday  
> vsyscall is a better
> long term solution, but doing that requires potentially several  
> implementations
> in the C library accross a range of architectures, some of which  
> may not be able
> to provide a time solution any better than what the gettimeofday  
> syscall
> provides today.  The /dev/rtc solution is easy, available right  
> now, and applies
> to all arches.

"All"?


Segher

