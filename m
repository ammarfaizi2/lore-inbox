Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263323AbTDMFkO (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 01:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263324AbTDMFkO (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 01:40:14 -0400
Received: from adsl-b3-72-20.telepac.pt ([213.13.72.20]:64138 "HELO
	puma-vgertech.no-ip.com") by vger.kernel.org with SMTP
	id S263323AbTDMFkN (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 13 Apr 2003 01:40:13 -0400
Message-ID: <3E98FB2E.7030300@vgertech.com>
Date: Sun, 13 Apr 2003 06:52:46 +0100
From: Nuno Silva <nuno.silva@vgertech.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
X-Accept-Language: en-us, pt
MIME-Version: 1.0
To: Frank Van Damme <frank.vandamme@student.kuleuven.ac.be>
CC: linux-kernel@vger.kernel.org
Subject: Re: stabilty problems using opengl on kt400 based system
References: <200304121410.58522.frank.vandamme@student.kuleuven.ac.be>
In-Reply-To: <200304121410.58522.frank.vandamme@student.kuleuven.ac.be>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello!

Frank Van Damme wrote:
> Hello,
> 

[..snip..]

> 
> The symptoms are as follows. Linux boots fine, the "radeon" kernel module
> inserts with no errors. X also starts without problems and runs stably in
> day-to-day work and during cpu-intensive tasks such as compiling. However, 
> if Istart running OpenGL applications (games) (quake,tuxracer or whatever) 
> themachine will freeze in anything from 2 minutes to an hour. The last frame
> remains on the screen, but I can still login over ssh and reboot.

And X is taking 99% of your CPU?

I have the *same* problem (mind the "99% from X" clause) with a nvidia 
geforce2. Couldn't find what the source of this was... But I can tell 
you that it's not the kernel.. I tried many combinations of kernel + 
nvidia drivers (that were running OK for many months) and it still 
freezes X. So, to me, it's X or glibc or something else, but:

As I don't need GL accell I just installed the nv driver from X :)

Anyway, back then I found some reports of people having the same 
problem. Google for it ;)

Regards,
Nuno Silva

