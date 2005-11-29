Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932355AbVK2Dme@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbVK2Dme (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 22:42:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbVK2Dme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 22:42:34 -0500
Received: from hulk.hostingexpert.com ([69.57.134.39]:56269 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S932355AbVK2Dmd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 22:42:33 -0500
Message-ID: <438BCE5F.7070108@m1k.net>
Date: Mon, 28 Nov 2005 22:43:27 -0500
From: Michael Krufky <mkrufky@m1k.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Krufky <mkrufky@m1k.net>
CC: Gene Heskett <gene.heskett@verizon.net>, linux-kernel@vger.kernel.org,
       Linux and Kernel Video <video4linux-list@redhat.com>,
       Don Koch <aardvark@krl.com>, Perry Gilfillan <perrye@linuxmail.org>
Subject: Re: cx88 totally fried in 2.6.15-rcX -was- Re: HD3000 - no NTSC via
 tuner
References: <200511282205.jASM5YUI018061@p-chan.krl.com> <200511281835.56805.gene.heskett@verizon.net> <438BAC38.3070505@m1k.net> <200511282125.52997.gene.heskett@verizon.net> <438BCCF9.1000606@m1k.net>
In-Reply-To: <438BCCF9.1000606@m1k.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Krufky wrote:

> Gene Heskett wrote:
>
>> Like I said, complete instructions please so that we are on the same
>> page.  I still have the rc2-git6 tree that didn't work, so as my script
>> does a make clean, it should be easy enough to do with the right
>> instructions.  Like what dir in the kernel tree am I supposed to be in
>> when I issue the cvs checkout command etc. 
>
Oops.... I forgot to answer this question....

It doesnt matter in what directory you are issuing the commands below... 
Although you certainly should NOT issue these within your kernel source, 
and you should be inside the newly-downloaded v4l-dvb tree after you 
"cd" into it.  I recommend either doing this in your ~home directory, or 
in /usr/src

> Here's how:
>
> 1) Please start with vanilla 2.6.15-rc2-git6 ... Have the kernel 
> already installed and running.
>
> 2) Check-out the newly merged v4l-dvb cvs repository:
>
>   cvs -d :pserver:anonymous@cvs.linuxtv.org:/cvs/video4linux login
>   cvs -d :pserver:anonymous@cvs.linuxtv.org:/cvs/video4linux co v4l-dvb
>
> 3) Change into the v4l-dvb directory:
>
>   cd v4l-dvb
>
> 4) (optional) If you are recompiling the cvs modules against a 
> different kernel, clean the tree and kernel version info:
>
>   make distclean
>
> 5) Compile the modules:
>
>   make
>
> 6) Install them: (as root)
>
>   make install
>
> 7) Reboot the machine
>
> Hopefully, this will fix your problem.  Please let me know. 

Cheers,

Michael
