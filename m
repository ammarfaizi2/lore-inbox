Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290132AbSAKV7A>; Fri, 11 Jan 2002 16:59:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290134AbSAKV6p>; Fri, 11 Jan 2002 16:58:45 -0500
Received: from 12-234-33-29.client.attbi.com ([12.234.33.29]:4160 "HELO
	top.worldcontrol.com") by vger.kernel.org with SMTP
	id <S290132AbSAKV63>; Fri, 11 Jan 2002 16:58:29 -0500
From: brian@worldcontrol.com
Date: Fri, 11 Jan 2002 13:56:50 -0800
To: Christiaan Kok <chrkok@chem.rug.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.17 gets really slow when handling large files
Message-ID: <20020111215650.GA2943@top.worldcontrol.com>
Mail-Followup-To: Brian Litzinger <brian@top.worldcontrol.com>,
	Christiaan Kok <chrkok@chem.rug.nl>, linux-kernel@vger.kernel.org
In-Reply-To: <m16OyYV-000t5oC@polypc17.chem.rug.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m16OyYV-000t5oC@polypc17.chem.rug.nl>
User-Agent: Mutt/1.3.23.2i
X-No-Archive: yes
X-Noarchive: yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2002 at 11:04:59AM +0100, Christiaan Kok wrote:
> Dear people,
> 
> I have a problem with kernel 2.4.17 and as far as I have testen all the 2.4.X
> kernels before it. When handling large files, like moving or viewing movies
> (700 Mb) (with mplayer) my system suddenly slows down a lot. This can only be
> repaired by a reboot. hdparm -Tt /dev/hdX values drop from around 25 MB/s to
> around 8 MB/s but DMA is still on (at least that is what hdaprm reports). In
> is a such a state it is imposible to burn cds for instance but networkspeed is
> unharmed.

How slow?  Does it always happen when playing large files with mplayer
or only some of the time?

I've run into a similar sounding problem.

Running mplayer, sometimes, perhaps 1 to 50 runs, the system becomes
nearly unresponsive.  I can switch virtual desktops in X, via WM,
promptly.  Through redraws of the switched-to desktop are slow.

xmms playing music continues to play fine.

rxvt's have about a 4 second response time.

Generally, I can manage rebooting the laptop.

Originally I blamed low-latency patches, and have switch back to
2.4.17 with preempt-patch.

-- 
Brian Litzinger <brian@worldcontrol.com>

    Copyright (c) 2002 By Brian Litzinger, All Rights Reserved
