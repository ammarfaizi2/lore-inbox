Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261479AbUJaCrh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261479AbUJaCrh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 22:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261482AbUJaCrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 22:47:37 -0400
Received: from out007pub.verizon.net ([206.46.170.107]:29346 "EHLO
	out007.verizon.net") by vger.kernel.org with ESMTP id S261479AbUJaCra
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 22:47:30 -0400
Message-ID: <41845241.2090104@verizon.net>
Date: Sat, 30 Oct 2004 22:47:29 -0400
From: Jim Nelson <james4765@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Z Smith <plinius@comcast.net>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: code bloat [was Re: Semaphore assembly-code bug]
References: <417550FB.8020404@drdos.com.suse.lists.linux.kernel>	 <200410310111.07086.vda@port.imtp.ilyichevsk.odessa.ua>	 <20041030222720.GA22753@hockin.org>	 <200410310213.37712.vda@port.imtp.ilyichevsk.odessa.ua> <1099176319.25194.10.camel@localhost.localdomain> <41843E10.1040800@comcast.net>
In-Reply-To: <41843E10.1040800@comcast.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out007.verizon.net from [209.158.211.53] at Sat, 30 Oct 2004 21:47:29 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Z Smith wrote:
> Alan Cox wrote:
> 
>> So if the desktop stuff is annoying you join gnome-love or whatever the
>> kde equivalent is 8)
> 
> 
> Or join me in my effort to limit bloat. Why use an X server
> that uses 15-30 megs of RAM when you can use FBUI which is 25 kilobytes
> of code with very minimal kmallocing?
> 
> home.comcast.net/~plinius/fbui.html
> 
> Zack Smith
> Bloat Liberation Front
> 

Because some of us use remote X clients on big iron with an X server on your 
desktop.  IIRC (been a long time since my CAD classes), a whole bunch of FEA and 
CAE/CAD applications worked this way.

There is a lot more flexibility inherent in user-space compared to kernel-space. 
You can use PAM, Kerberos, and a whole host of other security devices that would 
be difficult to implement efficiently in kernel-space.

Dude, that's a cool hack, but just about everything you did could be done with 
svgalib and the input core interface.  The advantage to svgalib is that if that 
interface dies, you can recover the machine pretty easily, whereas kernel panics 
are a bit more disruptive.

Still - it would be a nifty add-on for POS terminals, etc., just not the kind of 
thing I'd expect to see in the kernel anytime soon.  Once 2.7 is started, see if 
people are more receptive.  Take the time to flesh it out, get some more people on 
board, see if Sourceforge will host the project, and lose the advertising campaign 
- that's not likely to win any friends or supporters around here.

I don't mean to be harsh, but c'mon - "Bloat Liberation Front" - err... okaaay...

Good luck,

Jim
