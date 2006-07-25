Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751576AbWGYUxn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751576AbWGYUxn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 16:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751577AbWGYUxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 16:53:43 -0400
Received: from terminus.zytor.com ([192.83.249.54]:61350 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751575AbWGYUxm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 16:53:42 -0400
Message-ID: <44C6842C.8020501@zytor.com>
Date: Tue, 25 Jul 2006 13:50:52 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Neil Horman <nhorman@tuxdriver.com>
CC: Dave Airlie <airlied@gmail.com>,
       Segher Boessenkool <segher@kernel.crashing.org>,
       linux-kernel@vger.kernel.org, a.zummo@towertech.it, jg@freedesktop.org
Subject: Re: [PATCH] RTC: Add mmap method to rtc character driver
References: <20060725174100.GA4608@hmsreliant.homelinux.net> <03BCDC7F-13D9-42FC-86FC-30C76FD3B3B8@kernel.crashing.org> <20060725182833.GE4608@hmsreliant.homelinux.net> <44C66C91.8090700@zytor.com> <20060725192138.GI4608@hmsreliant.homelinux.net> <F09D8005-BD93-4348-9FD1-0FA5D8D096F1@kernel.crashing.org> <20060725194733.GJ4608@hmsreliant.homelinux.net> <21d7e9970607251304n5681bf44gc751c21fd79be99d@mail.gmail.com> <44C67E1A.7050105@zytor.com> <20060725204736.GK4608@hmsreliant.homelinux.net>
In-Reply-To: <20060725204736.GK4608@hmsreliant.homelinux.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Horman wrote:
> 
> Agreed.  How about we take the /dev/rtc patch now (since its an added feature
> that doesn't hurt anything if its not used, as far as tickless kernels go), and
> I'll start working on doing gettimeofday in vdso for arches other than x86_64.
> That will give the X guys what they wanted until such time until all the other
> arches have a gettimeofday alternative that doesn't require kernel traps.
> 

It hurts if it DOES get used.

	-hpa
