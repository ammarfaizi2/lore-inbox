Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290293AbSAQTqO>; Thu, 17 Jan 2002 14:46:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290352AbSAQTqE>; Thu, 17 Jan 2002 14:46:04 -0500
Received: from air-1.osdl.org ([65.201.151.5]:38408 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S290275AbSAQTpx>;
	Thu, 17 Jan 2002 14:45:53 -0500
Date: Thu, 17 Jan 2002 11:43:21 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Robert Love <rml@tech9.net>
cc: Barry Wu <wqb123@yahoo.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: how many cpus can linux support for SMP?
In-Reply-To: <1011253904.817.118.camel@phantasy>
Message-ID: <Pine.LNX.4.33L2.0201171141110.13155-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Jan 2002, Robert Love wrote:

| On Thu, 2002-01-17 at 01:59, Barry Wu wrote:
|
| > I am new to this mail list. I do not know how many CPUs linux can
| > support well using SMP. If some one knows, please give me
| > a reply. Thanks.
|
| 32.
|
| "well" though may mean many things and the answer depends on your
| workload.

On x86, using APICs, Pentium III maximum is 15 due to APIC addressing.
The IBM multiquad patch uses different APIC addressing (physical vs.
logical), so it goes beyond 15.
Pentium 4 APICs have addressing up to 255 IIRC, so they can do more
than P-III's 15.

-- 
~Randy

