Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265427AbUAZC44 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 21:56:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265437AbUAZC44
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 21:56:56 -0500
Received: from main.gmane.org ([80.91.224.249]:24707 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265427AbUAZC4z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 21:56:55 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Mike <Mike@kordik.net>
Subject: Re: 2.6.1-mm5, kernel panic "Interrupt not syncing"
Date: Sun, 25 Jan 2004 21:56:51 -0500
Message-ID: <pan.2004.01.26.02.56.50.928997@kordik.net>
References: <pan.2004.01.23.14.58.39.560168@kordik.net> <pan.2004.01.25.13.51.36.497433@kordik.net> <Pine.LNX.4.58.0401251020531.1741@montezuma.fsmlabs.com> <pan.2004.01.26.01.32.38.822806@kordik.net> <Pine.LNX.4.58.0401252057080.1741@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Pan/0.14.0 (I'm Being Nibbled to Death by Cats!)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Jan 2004 20:58:57 -0500, Zwane Mwaikambo wrote:

> On Sun, 25 Jan 2004, Mike wrote:
> 
>> >> > I have run 2.6.0-test.* kernels, 2.6.1-mm1 and 4 and they all boot
>> >> > fine. When I go to 2.6.1-mm5 I get a kernel panic and the boot
>> >> > freezes. The messages go by so quick I can't tell at what point it
>> >> > is doing this but the last line is interrupt not syncing. Any
>> >> > ideas? I have gone back to 2.6.1-mm4 so I can boot but I was
>> >> > interested in mm5 because it has ALSA 1.01 and I was hoping that
>> >> > would solve my lockup when I got to a web page with a lot of flash
>> >> > problem but not being able to boot is even worse. :-)
>> >> >
>> >> > Any ideas on the problem or advice on how to debug this would be
>> >> > most appreciated.
>> >> >
>> >> > Mike
>> >> No ideas? I can wait to try a newer kernel but I am concerned that
>> >> the 20 or so kernels I used before booted without problems then all
>> >> of a sudden 2.6.1-mm5 does not. Should I just ignore the problem and
>> >> try a newer kernel? Is anyone else using 2.6.1-mm5 successfully?
> 
> Ok i've got a few things for you to try, first try 2.6.1-mm5 without
> CONFIG_PREEMPT and then if that still fails, could you please try
> 2.6.2-rc1 and if that works, 2.6.2-rc1-mm3
> 
> Good luck
> 	Zwane
Zwane,
	Thanks for your help. Since you said there was newer version of the
kernel out I check the packages for my distro, Gentoo, and saw that they
had an ebuild ready for 2.6.2-rc1-mm3 I decided to give that a try first
and it boots fine. btw I left config_preempt=y

Thanks for your time in helping me get my system to boot again.

Mike

