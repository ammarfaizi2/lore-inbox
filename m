Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263814AbRFHCu6>; Thu, 7 Jun 2001 22:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263816AbRFHCus>; Thu, 7 Jun 2001 22:50:48 -0400
Received: from femail2.rdc1.on.home.com ([24.2.9.89]:34805 "EHLO
	femail2.rdc1.on.home.com") by vger.kernel.org with ESMTP
	id <S263814AbRFHCuk>; Thu, 7 Jun 2001 22:50:40 -0400
Date: Thu, 7 Jun 2001 22:50:33 -0400 (EDT)
From: "Mike A. Harris" <mharris@opensourceadvocate.org>
X-X-Sender: <mharris@asdf.capslock.lan>
To: "D. Stimits" <stimits@idcomm.com>
cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: missing sysrq
In-Reply-To: <3B16D852.91C5F2F1@idcomm.com>
Message-ID: <Pine.LNX.4.33.0106072250020.26171-100000@asdf.capslock.lan>
X-Unexpected-Header: The Spanish Inquisition
X-Spam-To: uce@ftc.gov
Copyright: Copyright 2001 by Mike A. Harris - All rights reserved
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 May 2001, D. Stimits wrote:

>Date: Thu, 31 May 2001 17:48:34 -0600
>From: D. Stimits <stimits@idcomm.com>
>To: unlisted-recipients:;;@timpanogas.com (no To-header on input)
>Cc: linux-kernel@vger.kernel.org
>Content-Type: text/plain; charset=us-ascii
>Subject: Re: missing sysrq
>
>Bernd Eckenfels wrote:
>>
>> In article <3B15EF16.89B18D@idcomm.com> you wrote:
>> > However, if I go to /proc/sys/kernel/sysrq does not exist.
>>
>> It is a compile time option, so the person who compiled your kernel left it
>> out.
>
>I compiled it, and the sysrq is definitely in the config. No doubt at
>all. I also use make mrproper and config again before dep and actual
>compile. Maybe it is just a quirk/oddball.

What does this say:

ksyms -a |grep -i sysrq


----------------------------------------------------------------------
    Mike A. Harris  -  Linux advocate  -  Open Source advocate
       Opinions and viewpoints expressed are solely my own.
----------------------------------------------------------------------
Who knows what dangerous code lurks in the hearts of men?
Only the Shadowman(TM) knows...  Mike A. Harris <mharris@redhat.com>

