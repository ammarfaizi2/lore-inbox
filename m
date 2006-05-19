Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932267AbWESLCL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbWESLCL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 07:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262AbWESLCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 07:02:11 -0400
Received: from alpha.uhasselt.be ([193.190.2.30]:33707 "EHLO alpha.uhasselt.be")
	by vger.kernel.org with ESMTP id S932267AbWESLCK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 07:02:10 -0400
Message-ID: <446DA5B0.8020703@lumumba.uhasselt.be>
Date: Fri, 19 May 2006 13:02:08 +0200
From: Panagiotis Issaris <takis@lumumba.uhasselt.be>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Richard Moser <nigelenki@comcast.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Stealing ur megahurts (no, really)
References: <446D61EE.4010900@comcast.net>
In-Reply-To: <446D61EE.4010900@comcast.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

John Richard Moser wrote:

>[...]
>Scrambling for an old machine is ridiculous.  Down-clocking makes sense
>because you can adjust to varied levels; but it's difficult and usually
>infeasible.  Pulling memory and mix and matching is not much better.
>
>On Linux we have mem= to toy with memory, which I personally HAVE used
>to evaluate how various distributions and releases of GNOME operate
>under memory pressure.  This is a lot more convenient than pulling chips
>and trying to find the right combination.  This option was, apparently,
>designed for situations where actual system memory capacity is
>mis-detected (mandrake 7.2 and its insistence that a 256M memory stick
>is 255M....); but is very useful in this application too.
>[...]
>  
>
An easier way might be to use a system emulator like Qemu.
You can specify the amount of memory the emulated system has,
and if you do not use the kernel accelerating module (kqemu)
it slows down considerably.

Of course, it would be nicer if you could actually specify performance
levels and an issue with this approach is that it does not uniformly
scale down performance: I think IO emulation performance is a lot worse
then CPU emulation performance (in Qemu).

With friendly regards,
Takis

