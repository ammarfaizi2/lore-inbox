Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316089AbSH0OHt>; Tue, 27 Aug 2002 10:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316182AbSH0OHt>; Tue, 27 Aug 2002 10:07:49 -0400
Received: from h24-68-93-250.vc.shawcable.net ([24.68.93.250]:36742 "EHLO
	me.bcgreen.com") by vger.kernel.org with ESMTP id <S316089AbSH0OHs>;
	Tue, 27 Aug 2002 10:07:48 -0400
Message-ID: <3D6B88AE.8010206@bcgreen.com>
Date: Tue, 27 Aug 2002 07:11:58 -0700
From: Stephen Samuel <samuel@bcgreen.com>
Organization: Just Another Radical
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Wessler, Siegfried" <Siegfried.Wessler@de.hbm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: interrupt latency
References: <D3524C0FFDC6A54F9D7B6BBEECD341D5D56FDB@HBMNTX0.da.hbm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://www.linux.org/dist/index.html contains an index to a number of
Linux distributions.  Check out the embeded kernels. They include some
Realtime mods. As an example, RTLinux claims to do hard realtime by
running the Linux kernel as it's lowest priority task. This is supposed
to allow serious realtime work without having to mess too much with
the kernel.

Wessler, Siegfried wrote:
> Hello,
> 
> I am running and will in near future kernel 2.4.18 on an embedded system.
> 
> I have to speed up interrupt latency and need to understand how in what
> timing tasklets are called and arbitraded.
  .....
> What's behind it: We patched NMI and do some stuff we have to do very
> regularly in there. After NMI we have to quiet fast start a kernel or even a
> user space function with low latency. Also I measured 8 milliseconds after a
> hardware interrupt before the corresponding interrupt function is called. At
> RTI time it is even longer (around 12 microseconds). Need to find a way to
> exactly understand why, and maybe speed up a bit.
-- 
Stephen Samuel +1(604)876-0426                samuel@bcgreen.com
		   http://www.bcgreen.com/~samuel/
Powerful committed communication, reaching through fear, uncertainty and
doubt to touch the jewel within each person and bring it to life.

