Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265415AbUAZB7n (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 20:59:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265431AbUAZB7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 20:59:43 -0500
Received: from modemcable178.89-70-69.mc.videotron.ca ([69.70.89.178]:64386
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S265415AbUAZB7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 20:59:42 -0500
Date: Sun, 25 Jan 2004 20:58:57 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Mike <Mike@kordik.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.1-mm5, kernel panic "Interrupt not syncing"
In-Reply-To: <pan.2004.01.26.01.32.38.822806@kordik.net>
Message-ID: <Pine.LNX.4.58.0401252057080.1741@montezuma.fsmlabs.com>
References: <pan.2004.01.23.14.58.39.560168@kordik.net>
 <pan.2004.01.25.13.51.36.497433@kordik.net> <Pine.LNX.4.58.0401251020531.1741@montezuma.fsmlabs.com>
 <pan.2004.01.26.01.32.38.822806@kordik.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Jan 2004, Mike wrote:

> >> > I have run 2.6.0-test.* kernels, 2.6.1-mm1 and 4 and they all boot
> >> > fine. When I go to 2.6.1-mm5 I get a kernel panic and the boot
> >> > freezes. The messages go by so quick I can't tell at what point it is
> >> > doing this but the last line is interrupt not syncing. Any ideas? I
> >> > have gone back to 2.6.1-mm4 so I can boot but I was interested in mm5
> >> > because it has ALSA 1.01 and I was hoping that would solve my lockup
> >> > when I got to a web page with a lot of flash problem but not being
> >> > able to boot is even worse. :-)
> >> >
> >> > Any ideas on the problem or advice on how to debug this would be most
> >> > appreciated.
> >> >
> >> > Mike
> >> No ideas? I can wait to try a newer kernel but I am concerned that the
> >> 20 or so kernels I used before booted without problems then all of a
> >> sudden 2.6.1-mm5 does not. Should I just ignore the problem and try a
> >> newer kernel? Is anyone else using 2.6.1-mm5 successfully?

Ok i've got a few things for you to try, first try 2.6.1-mm5 without
CONFIG_PREEMPT and then if that still fails, could you please try
2.6.2-rc1 and if that works, 2.6.2-rc1-mm3

Good luck
	Zwane

