Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281737AbRKQMly>; Sat, 17 Nov 2001 07:41:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281740AbRKQMlp>; Sat, 17 Nov 2001 07:41:45 -0500
Received: from mail.cogenit.fr ([195.68.53.173]:22754 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S281737AbRKQMlf>;
	Sat, 17 Nov 2001 07:41:35 -0500
Date: Sat, 17 Nov 2001 13:41:27 +0100
From: Francois Romieu <romieu@cogenit.fr>
To: Jan Kasprzak <kas@informatics.muni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VM tuning for Linux routers
Message-ID: <20011117134127.A8041@se1.cogenit.fr>
In-Reply-To: <20011116090322.G20714@informatics.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011116090322.G20714@informatics.muni.cz>; from kas@informatics.muni.cz on Fri, Nov 16, 2001 at 09:03:22AM +0100
X-Organisation: Marie's fan club - II
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kasprzak <kas@informatics.muni.cz> :
[...]
> 	I have a dual Athlon w/ 512M RAM and three NICs (one gigabit
> 3c985B running 802.1Q with 5 VLANs, two on-board 100Mbit 3c982). This box
> has almost nothing other to do apart from routing and packet filtering.
> Is there anything I can do to tell the VM system to use as much memory
> for network packets as possible?

In a sysctl fashion ? No.
However you can increase the length of the Rx/Tx rings on the 100Mb/s side 
and tune the pci latency timers (depends on the hardware fifo size). 

-- 
Ueimor
