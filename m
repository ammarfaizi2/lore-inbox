Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268199AbRHCJ5y>; Fri, 3 Aug 2001 05:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268129AbRHCJ5o>; Fri, 3 Aug 2001 05:57:44 -0400
Received: from [210.77.38.126] ([210.77.38.126]:47377 "EHLO
	ns.turbolinux.com.cn") by vger.kernel.org with ESMTP
	id <S268079AbRHCJ5b>; Fri, 3 Aug 2001 05:57:31 -0400
Date: Fri, 3 Aug 2001 17:58:03 +0800
From: michael chen <michaelc@turbolinux.com.cn>
X-Mailer: The Bat! (v1.49) UNREG / CD5BF9353B3B7091
Reply-To: michaelc <michaelc@turbolinux.com.cn>
X-Priority: 3 (Normal)
Message-ID: <3823096796.20010803175803@turbolinux.com.cn>
To: rtviado <root@iligan.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: load balancing on more than 1 default routes
In-Reply-To: <Pine.LNX.4.33.0108031752040.907-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.33.0108031752040.907-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi rtviado,

Friday, August 03, 2001, 6:02:48 PM, you wrote:



r> Hello,

r>         I just want to ask if there is a facility in the kernel that load
r> balance to different default routes, since i'm using this routes for
r> uplink purposes only (my downlink is via satellite, it doesn't matter
r> where i send my packets uplink as long as it reaches the internet
r> backbone).

r> for example

r>         in my box, I have routes as describe below

r>         destination     gateway         netmask
r>         default         isp1            0.0.0.0
r>         default         isp2            0.0.0.0

r> Want i want is for the kernel to load balance (e.g round robin) uplink
r> packets to isp1 and isp2. If this in is not possible in the current
r> kernel, where in the kernel source files can i start hacking to make this
r> possible?


r> TIA
    As i know, there is a networking driver called bonding ,which can
    load balance sending packets through several ethernet
    connections, both 2.2.X and 2.4.X kernel have this driver.


-- 
Best regards,
Michael Chen                           mailto:michaelc@turbolinux.com.cn


