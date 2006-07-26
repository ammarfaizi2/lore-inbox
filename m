Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751617AbWGZNSA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751617AbWGZNSA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 09:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751622AbWGZNSA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 09:18:00 -0400
Received: from dvhart.com ([64.146.134.43]:28347 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1751617AbWGZNR7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 09:17:59 -0400
Message-ID: <44C76B85.5040708@mbligh.org>
Date: Wed, 26 Jul 2006 06:17:57 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Neil Horman <nhorman@tuxdriver.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Dave Airlie <airlied@gmail.com>,
       Segher Boessenkool <segher@kernel.crashing.org>,
       linux-kernel@vger.kernel.org, a.zummo@towertech.it, jg@freedesktop.org
Subject: Re: [PATCH] RTC: Add mmap method to rtc character driver
References: <20060725174100.GA4608@hmsreliant.homelinux.net> <03BCDC7F-13D9-42FC-86FC-30C76FD3B3B8@kernel.crashing.org> <20060725182833.GE4608@hmsreliant.homelinux.net> <44C66C91.8090700@zytor.com> <20060725192138.GI4608@hmsreliant.homelinux.net> <F09D8005-BD93-4348-9FD1-0FA5D8D096F1@kernel.crashing.org> <20060725194733.GJ4608@hmsreliant.homelinux.net> <21d7e9970607251304n5681bf44gc751c21fd79be99d@mail.gmail.com> <44C67E1A.7050105@zytor.com> <20060725204736.GK4608@hmsreliant.homelinux.net>
In-Reply-To: <20060725204736.GK4608@hmsreliant.homelinux.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Agreed.  How about we take the /dev/rtc patch now (since its an added feature
>that doesn't hurt anything if its not used, as far as tickless kernels go), and
>I'll start working on doing gettimeofday in vdso for arches other than x86_64.
>That will give the X guys what they wanted until such time until all the other
>arches have a gettimeofday alternative that doesn't require kernel traps.
>  
>

The timelag involved in rolling X into a distro and releasing
it means that we don't really need short term workarounds.
Introducing new userspace APIs is not something that
should be done casually.
