Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263448AbTCNTKJ>; Fri, 14 Mar 2003 14:10:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263447AbTCNTKJ>; Fri, 14 Mar 2003 14:10:09 -0500
Received: from realityfailure.org ([209.150.103.212]:18948 "EHLO
	bushido.realityfailure.org") by vger.kernel.org with ESMTP
	id <S263448AbTCNTKH>; Fri, 14 Mar 2003 14:10:07 -0500
Date: Fri, 14 Mar 2003 14:20:22 -0500 (EST)
From: John Jasen <jjasen@realityfailure.org>
X-X-Sender: jjasen@bushido
To: N Nair <nandagopalnair@netscape.net>
cc: linux-kernel@vger.kernel.org, <gleblanc@linuxweasel.com>
Subject: Re: Posting of the Linux RAID FAQ
In-Reply-To: <3E721ABB.7050401@netscape.net>
Message-ID: <Pine.LNX.4.44.0303141415030.8584-100000@bushido>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Mar 2003, N Nair wrote:

> the time being? In other words can the user choose to wait and do the 
> resync at what he thinks is a more appropriate time - in terms of 
> resouce availability - ( at night, for instance ) if he is willing to 
> take up the risk involved ? If yes, how can the kernel raid-recovery 
> processes be stopped/controlled ?

You have /proc/sys/dev/raid/speed_limit_max and _min, where you can 
specifiy upper and lower bounds for how fast the raid resyncs.

I imagine you could use cron or at to whack together something to arrange 
higher speed resyncs during offhours.


-- 
-- John E. Jasen (jjasen@realityfailure.org)
-- User Error #2361: Please insert coffee and try again.


