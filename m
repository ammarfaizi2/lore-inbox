Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130170AbRBWI5h>; Fri, 23 Feb 2001 03:57:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130169AbRBWI5Y>; Fri, 23 Feb 2001 03:57:24 -0500
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:4100 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S129876AbRBWI5B>;
	Fri, 23 Feb 2001 03:57:01 -0500
Message-ID: <20010222215146.D14395@bug.ucw.cz>
Date: Thu, 22 Feb 2001 21:51:46 +0100
From: Pavel Machek <pavel@suse.cz>
To: zhaoway <zw@debian.org>, linux-kernel@vger.kernel.org
Subject: Re: Newbie ask for help: cramfs port to isofs
In-Reply-To: <877l2lyk3j.fsf@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <877l2lyk3j.fsf@debian.org>; from zhaoway on Tue, Feb 20, 2001 at 02:03:12PM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I've nearly no prior experience with kernel hacking (nor C if you have
> to ask, haha), sorry in advance for the newbiesh looking. ;-)
> 
> See attach for a rough try to port cramfs to isofs which gave me lots
> of oops and reboots and fscks this week. Please if you have some spare
> time to give it a look with your experienced eyes to help me out of
> this helpless state. Thanks alot!
> 
> I plan to automatically de-compressing ``*.cramed'' files made with
> cramit.c (which is a simplified version of mkcramfs.c also attached
> below) from within isofs.o. This indeed isn't a very clean idea I
> agree. If you have better design, please let me know.

Nice toy: I believe that it should even _speed up_
operations. Surely if you have k6/400 with 4x cdrom like me ;-).

> My problem is that when I after mount ``$ file somefile.not.cram.ed''
> the kernel hangs. And my de-compression code surely has some thing

strace file somefile.not.cram.ed, and looks what what goes bad.

								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
