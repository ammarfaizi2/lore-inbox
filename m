Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261901AbTKCEnw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 23:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261903AbTKCEnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 23:43:52 -0500
Received: from mail-06.iinet.net.au ([203.59.3.38]:40663 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261901AbTKCEnv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 23:43:51 -0500
Message-ID: <3FA5DD01.1070109@cyberone.com.au>
Date: Mon, 03 Nov 2003 15:43:45 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Erwin Telser <erwin.telser@pop.agri.ch>
CC: linux-kernel@vger.kernel.org
Subject: Re: Responsiveness of 2.6.0-Test9
References: <200311022345.08192.erwin.telser@pop.agri.ch>
In-Reply-To: <200311022345.08192.erwin.telser@pop.agri.ch>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Erwin Telser wrote:

>Are there things to observe when switching from 2.4 to 2.6, if I want the same 
>responsiveness? I'm asking because I' ve made the following observation. (I 
>always had the feeling, 2.4 seems to faster, but this is the first time it' s 
>very obvious)
>
>I' ve connected two monitors on a Matrox G550. One runs with DRI the other one 
>doesn't (not possible with the current driver). The Monitor with DRI I'm 
>using as a TV Set, watching movies with xawtv. (With a bttv 878 tuner card).
>
>Now with the 2.4.22 kernel (preemptible patch aplied) I can play the little 
>game kbounce on the other monitor, without to notice any slowdown, no matter, 
>whether xawtv is running or not.
>
>But with the 2.6 Kernel (compiled with preemptible option) the bouncing balls 
>slow down considerably, as soon as I move the mouse.
>
>I know the whole thing is a little foolish. But anyway, are there some tricks 
>to get the same responsiveness?
>

Hi,
Your report is not foolish at all ;)
Please make sure your X process is at default static priority, 0.
Report back if you are still having problems. What sort of processor
do you have? Is your 2.6 video driver running with the same sort of
acceleration as your 2.4 one (do you get the same frame rate in glxgears)?


