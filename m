Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269953AbRHJRTw>; Fri, 10 Aug 2001 13:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269952AbRHJRTn>; Fri, 10 Aug 2001 13:19:43 -0400
Received: from smtp.awc.net ([216.205.112.6]:61199 "EHLO mx-a.awc.net")
	by vger.kernel.org with ESMTP id <S269957AbRHJRTi>;
	Fri, 10 Aug 2001 13:19:38 -0400
For: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=US-ASCII
From: Caleb Tennis <caleb@aei-tech.com>
Organization: Analytical Engineering, Inc.
To: "Stuart MacDonald" <stuartm@connecttech.com>,
        <linux-kernel@vger.kernel.org>, <tytso@mit.edu>
Subject: Re: [PATCH] serial.c to support ConnectTech Blueheat PCI
Date: Fri, 10 Aug 2001 12:21:31 -0500
X-Mailer: KMail [version 1.2]
In-Reply-To: <01081010190800.03758@pete.aei-tech.com> <017801c121b5$e254f3e0$294b82ce@connecttech.com>
In-Reply-To: <017801c121b5$e254f3e0$294b82ce@connecttech.com>
MIME-Version: 1.0
Message-Id: <01081012213100.08017@pete.aei-tech.com>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 August 2001 11:02, Stuart MacDonald wrote:

> This patch is maintained by me; it applies to 5.05. I'm not sure how
> 5.05[abc] are different from vanilla 5.05 though.

I'm quite pleased at the support ConnectTech has for this product.  We are 
planning on purchasing more in the future.

>
> The reason this patch hasn't been seen on lkml is that I prefer
> to have all the serial driver patches go through Ted (T'so the
> serial driver maintainer) first. He's rejected this patch once
> already on the basis that it adds specific board functionality to
> the driver, which he's trying to avoid. I resubmitted it Jun 27 2001
> with a lengthy explanation that all boards with half duplex and slave
> multiplex functionality would have to have some method of doing the
> switching between the modes, and that this isn't specific to our
> products. I haven't heard back from him since.

I originally applied the ConnectTech patch a few months ago to a 2.2.19 
kernel.  I ran into a lot of problems related to the serial driver 5.05 
having some errors in it.  it would compile just fine as as module, but not 
when integrated into the kernel.  There were almost 20 patches to the serial 
driver up on sourceforge fixing most of these problems - and they took care 
of the situation.  After looking at the sourceforge site, it seemed like Ted 
Tso isn't actively maintaining the serial driver anymore (though I noticed 
activity from him on other projects he supports, like e2fsprogs) and my 
assumption was that he was busy.  I had noticed that in the 2.4 series, some 
modifications had been made to the serial driver (hence the "abc" 
progression), and thought it may be valuable to submit a patch related to the 
latest kernel.

There really isn't a good way around this patch - I understand Ted's concern 
on board specific functionality, but it is quite extendable to other 485/232 
combination boards as well.  I sure hope it makes it into the kernel at some 
point, but if not I'll continue hand patching away :)

> Caleb: I appreciate the effort, thanks.

Not a problem - it was a fun way to spend a day upgrading to 2.4.  In fact, 
the serial driver was the only snag I ran into during the upgrade process.

-- 
Caleb Tennis
Analytical Engineering
2555 Technology Blvd
Columbus, IN 47201
