Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262191AbUCIU7Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 15:59:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262193AbUCIU7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 15:59:24 -0500
Received: from FW-30-241.go.retevision.es ([62.174.241.30]:22349 "EHLO
	nebula.ghetto") by vger.kernel.org with ESMTP id S262191AbUCIU6X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 15:58:23 -0500
Date: Tue, 9 Mar 2004 21:57:20 +0100
To: linux-kernel@vger.kernel.org
Cc: Ludootje <ludootje@linux.be>
Subject: Re: performance better in 2.6.1 than in 2.6.3
Message-ID: <20040309205720.GA10182@larroy.com>
Reply-To: piotr@larroy.com
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Ludootje <ludootje@linux.be>
References: <1078867762.4908.20.camel@gax.mynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1078867762.4908.20.camel@gax.mynet>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: piotr@larroy.com (Pedro Larroy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2004 at 09:29:22PM +0000, Ludootje wrote:
> Hi,
> 
> I'm currently using Linux 2.6.1 (vanilla, no patches applied). I've never used
> 2.6.2, but I did compile 2.6.3 (vanilla too) a few weeks ago, and I used that
> for a while.
> 
> When I use KDE and start some 'heavy' applications with 2.6.3, I have
> performance problems. Example: amaroK is playing music in KDE, I start
> up Firebird or Evolution, and the music 'skips' a bit. It doesn't stop playing,
> it just skips some bits. When the app is loaded, all is fine again.
> I don't have this behaviour in 2.6.1, so I'm using that again ATM.
> 
> I used the same configuration each time (attached is my /proc/config.gz).
> I'm using an AMD Athlon XP 2400+.
> 
> I don't know how I can 'show' the problem, as I don't think the load average
> is useful for this problem, so I'm not including it. I really have no idea what
> can be useful, so please tell me what stuff I should add (if any).
> 
> I'm sorry if this a known problem, but I don't remember seeing something like
> this on the list.
> 
> Thanks,
> Ludootje


Maybe you want to try a little IO latency measurement program to see if the
skips are beeing caused by disk/ioscheduling delays, it's in:

http://pedro.larroy.com/devel/iolat/

Here: http://pedro.larroy.com/devel/iolat/analisys/
are some measures from an ide disk in a AMD-768 chipset and a scsi
cheetah 10K on an AIC-7892A U160/m.

I'm still working to find why those delays in the ide disk.

Regards.

--
Pedro Larroy Tovar | Linux & Network consultant |  piotr%member.fsf.org
Software patents are a threat to innovation in Europe please check:
        http://www.eurolinux.org/

