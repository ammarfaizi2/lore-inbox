Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265567AbTBXIcJ>; Mon, 24 Feb 2003 03:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265568AbTBXIcJ>; Mon, 24 Feb 2003 03:32:09 -0500
Received: from angband.namesys.com ([212.16.7.85]:1920 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S265567AbTBXIcH>; Mon, 24 Feb 2003 03:32:07 -0500
Date: Mon, 24 Feb 2003 11:42:19 +0300
From: Oleg Drokin <green@namesys.com>
To: "John W. M. Stevens" <john@betelgeuse.us>
Cc: thetech@folkwolf.net, linux-kernel@vger.kernel.org
Subject: Re: Box freezes if I enable "AMD 76x native power management"
Message-ID: <20030224114219.B874@namesys.com>
References: <20030222163057.A884@namesys.com> <20030222185329.GA22170@morningstar.nowhere.lie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030222185329.GA22170@morningstar.nowhere.lie>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Sat, Feb 22, 2003 at 11:53:29AM -0700, John W. M. Stevens wrote:
> >    Starting from 2.4.20 until now (including 2.4.21-pre4 and 2.4.21-pre4-ac5",
> >    whenever I enable "AMD 76x native power management" in my kernel config, I get
> >    kernel that hangs at boot after reporting elevator stuff about my IDE drives.
> >    Is anybody interested?
> I am.  This sounds suspiciously like the bug I reported.

Hm.

> But you haven't given quite enough information for me to compare.  Can
> you send:
> 1) Exact Mother board (Tyan what?  Tiger MPX 2466N . . . ?)

Tyan Tiger MP (bios v1.03)

> 2) Do you have DMA turned on for your IDE drives?

Yes. Tried to boot with "ide=nodma". It hung too, but
first emitted about set_drive_speed_blah: ... error messages.

> 3) Are you enabling the AMD chip support for IDE?

Yes. I tried to disable "AMD Viper" IDE support in kernel,
but that did not help.

> . . . and anything else you can find out about the box?

Well, dual cpu athlon 1700+, 1G RAM. 2 IDE disks on primary channel.
Geforce3 video card. Some cheap cmpci sound board.
That's it.

> Most importantly . . . does the problem go away if you turn off DMA
> support for IDE?

No.

Bye,
    Oleg
