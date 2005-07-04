Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261528AbVGDS16@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbVGDS16 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 14:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261524AbVGDS16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 14:27:58 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:52396
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S261566AbVGDSYt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 14:24:49 -0400
Message-ID: <42C970D1.3090609@linuxwireless.org>
Date: Mon, 04 Jul 2005 12:24:33 -0500
From: Alejandro Bonilla <abonilla@linuxwireless.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Shawn Starr <shawn.starr@rogers.com>, Lenz Grimmer <lenz@grimmer.com>,
       Jesper Juhl <jesper.juhl@gmail.com>, Dave Hansen <dave@sr71.net>,
       Henrik Brix Andersen <brix@gentoo.org>,
       hdaps-devel@lists.sourceforge.net,
       LKML List <linux-kernel@vger.kernel.org>
Subject: Re: IBM HDAPS things are looking up
References: <20050704061713.GA1444@suse.de> <20050704142723.2202.qmail@web88009.mail.re2.yahoo.com> <20050704144634.GQ1444@suse.de>
In-Reply-To: <20050704144634.GQ1444@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

>
>That's madness, we can't add a kernel thread for every single little
>silly thing. You don't need to stop any io, you just want to make sure
>that your park request gets issued right after the current io has
>finished.
>  
>
HI,

    For me, the heads have to park so fast. That I would be afraid of a 
kernel panil or something that could happen if you park the head so fast 
that it won't even tell the kernel it did, or because ext3 couldn't 
update or any crazy reason.

    I use a lot a project called laptop_mode, which suspend the hd until 
you do a request to the kernel or the HD and it spins up the HD. I think 
somehow, the kernel is not fast enough to do what we want, I mean, I 
don't see it.

    Imagine you are in starbucks, your laptop is over a 1.2 M table, 
Linus just said that a new kernel is out. So you simply download it, and 
now you are compiling it. But, you invited your kid to Starbucks. And 
while your CPU is at 100% and full throttle HD usage. Then your kid 
trips on the cable or simply pushes the PC out.

    Do you think that the kernel will STOP, HOLD and park the head in 
less than a second? OR on the time we need?

    I would say is a dammed good kernel if it would. (could RTOS, make 
things faster)

Simply send the flames my way if you think I'm totally wrong. Which I 
might be. I really don't know...

.Alejandro
