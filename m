Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265136AbUAaWPV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 17:15:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265152AbUAaWPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 17:15:21 -0500
Received: from mail48-s.fg.online.no ([148.122.161.48]:57231 "EHLO
	mail48-s.fg.online.no") by vger.kernel.org with ESMTP
	id S265136AbUAaWPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 17:15:15 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Software Suspend 2.0
References: <20040131071619.GD7245@digitasaru.net>
	<1075534088.18161.61.camel@laptop-linux>
	<20040131073848.GE7245@digitasaru.net>
	<1075537924.17730.88.camel@laptop-linux> <401B6F7A.5030103@gmx.de>
	<1075540107.17727.90.camel@laptop-linux> <401B7312.3060207@gmx.de>
	<1075542685.25454.124.camel@laptop-linux> <401B86EB.50604@gmx.de>
	<yw1xznc4tfle.fsf@kth.se> <20040131231134.GA6084@digitasaru.net>
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: Sat, 31 Jan 2004 23:15:12 +0100
In-Reply-To: <20040131231134.GA6084@digitasaru.net> (Joseph Pingenot's
 message of "Sat, 31 Jan 2004 17:11:37 -0600")
Message-ID: <yw1x8yjnsr2n.fsf@kth.se>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joseph Pingenot <trelane@digitasaru.net> writes:

> From Måns Rullgård on Saturday, 31 January, 2004:
>>"Prakash K. Cheemplavam" <PrakashKC@gmx.de> writes:
>>>> My error. My patch script has put kernel/power/swsusp2.c in the version
>>> No problem. I already tested it. After throwing out usb modules, it
>>> did suspend, though taking quite long at the kernel and processing
>>> (something like that) message. But upon restart, it didn't resume,
>>> ie. it didn't find its image, just normal swap space.
>>Try disabling write cache on the disk with hdparm -W0 /dev/hde.
>
> When should this be done?
>
> I have 2.6.1 + the 2.6.1-specific patches + core patches.  It suspends
>   without difficulty, but on boot, it says it couldn't read a part
>   of the resume data (a "chunk", iirc).  The status bar doesn't make
>   much progress.
>
> I tried hdparm -W 0 right before the call to hibernate (in a script).

That did the trick for me.  You must be having a different problem.

>   But I still have the problem.
>
> When should hdparm be called?
>
> Thanks!
>
> -Joseph

-- 
Måns Rullgård
mru@kth.se
