Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130531AbRBMHLg>; Tue, 13 Feb 2001 02:11:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130612AbRBMHL0>; Tue, 13 Feb 2001 02:11:26 -0500
Received: from smtp-out1.bellatlantic.net ([199.45.40.143]:37044 "EHLO
	smtp-out1.bellatlantic.net") by vger.kernel.org with ESMTP
	id <S130531AbRBMHLP>; Tue, 13 Feb 2001 02:11:15 -0500
Message-ID: <3A88DE0E.42EE74F5@cdi.com>
Date: Tue, 13 Feb 2001 02:11:10 -0500
From: "Rafael E. Herrera" <raffo@cdi.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Animated framebuffer logo for 2.4.1
In-Reply-To: <20010201183231.A373@tuxia.com> <l03130323b6ae7005d490@[192.168.239.101]>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Not good enough in isolation.  Suppose the kernel freezes at a very early
> stage, such as while detecting the CPU(s) or PCI bridge - are your geeky
> reaction times fast enough to dismiss the logo in time to see the relevant
> messages?  I agree with others that this should be a boot option - and not
...
> Eg: in lilo.conf use append = "bootlogo" to turn the logo on (it should
> always be off by default, but can be turned on by distro makers or
> end-users) - but then if you type "linux nologo" at the LILO prompt, the
> "nologo" should over-ride the "bootlogo" so there's always a way to see all
> the messages.

In a PC and if using lilo, you always get a lilo prompt (if so
configured) after the initial power on tests. Passing a "nologo" option
to lilo would seem a reasonable way to turn the feature off. The same
could apply to othe boot loaders and other archs. By the way, suse 7.1
has a graphical boot, no animation though, just a big penguin; some
hacked lilo version, maybe?
-- 
     Rafael
