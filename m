Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135681AbRDZQIt>; Thu, 26 Apr 2001 12:08:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135685AbRDZQI3>; Thu, 26 Apr 2001 12:08:29 -0400
Received: from kanga.kvack.org ([216.129.200.3]:51218 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id <S135681AbRDZQI1>;
	Thu, 26 Apr 2001 12:08:27 -0400
Date: Thu, 26 Apr 2001 12:03:08 -0400 (EDT)
From: <kernel@kvack.org>
To: Yiping Chen <YipingChen@via.com.tw>
cc: "'Vivek Dasmohapatra'" <vivek@etla.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: About rebuild 2.4.x kernel to support SMP.
In-Reply-To: <611C3E2A972ED41196EF0050DA92E0760265D56B@EXCHANGE2>
Message-ID: <Pine.LNX.3.96.1010426120128.28828A-100000@kanga.kvack.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Apr 2001, Yiping Chen wrote:

> So, I have two question now, 
> 1. how to determine whether your kernel support SMP?
>     Somebody taugh me that you can type  "uname -r", but it seems not
> correct.

No, it's correct: the Red Hat RPM is build from the kernel.spec file which
adds the smp string to the version.

> 2. I remember in 2.2.x, when I rebuild the kernel which support SMP, the
> compile
>     argument will include -D__SMP__ , but this time, when I rebuild kernel
> 2.4.2-2 , it didn't  appear.
>     Why? 

Because you've made an assumption that holds no value.  2.4 kernels rely
on CONFIG_SMP instead of __SMP__.

		-ben

