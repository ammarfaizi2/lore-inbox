Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131363AbRCNOIZ>; Wed, 14 Mar 2001 09:08:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131364AbRCNOIQ>; Wed, 14 Mar 2001 09:08:16 -0500
Received: from s057.dhcp212-109.cybercable.fr ([212.198.109.57]:56837 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S131363AbRCNOIG>; Wed, 14 Mar 2001 09:08:06 -0500
Message-ID: <3AAF7AD1.D24E526C@baretta.com>
Date: Wed, 14 Mar 2001 15:06:09 +0100
From: Alex Baretta <alex@baretta.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: it, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 5Mb missing...
In-Reply-To: <Pine.LNX.4.33.0103070958110.1424-100000@mikeg.weiden.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote:
> 
> If crashes are routine on this machine, I'd recommend that you take
> a serious look at your ram. (or if you're overclocking, don't)

Crashes were routine, and I was not overclocking, so I took Mike's
advice and bought a new 256MB DIMM. The computer hasn't crashed
once since I installed it. Now, though, I have a curious though
fairly irrelevant problem. My kernel apparently sees less RAM than
I have.


[alex@localhost /home]$ free -m
             total       used       free     shared    buffers    
cached
Mem:           251        209         42         60        
61         92
-/+ buffers/cache:         55        196


I strongly doubt this can be a bug in the kernel. Could anyone
explain to me why this might happen?

Alex
