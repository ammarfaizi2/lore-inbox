Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269421AbTCDNQM>; Tue, 4 Mar 2003 08:16:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269422AbTCDNQM>; Tue, 4 Mar 2003 08:16:12 -0500
Received: from [202.109.126.231] ([202.109.126.231]:4156 "HELO
	www.support-smartpc.com.cn") by vger.kernel.org with SMTP
	id <S269421AbTCDNQL>; Tue, 4 Mar 2003 08:16:11 -0500
Message-ID: <3E64A8A5.4EBB5FB3@mic.com.tw>
Date: Tue, 04 Mar 2003 21:22:45 +0800
From: "rain.wang" <rain.wang@mic.com.tw>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: system hang on HDIO_DRIVE_RESET! help!
References: <3E5CEF17.4C014A4C@mic.com.tw> <1046288652.9837.18.camel@irongate.swansea.linux.org.uk> <3E5EEDF9.5906D73E@mic.com.tw>
Content-Type: text/plain; charset=x-user-defined
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Mar 2003 13:19:13.0078 (UTC) FILETIME=[A60AC560:01C2E250]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"rain.wang" wrote:

> Alan Cox wrote:
>
> > On Wed, 2003-02-26 at 16:45, rain.wang wrote:
> > > Hi,
> > >     I did HDIO_DRIVE_RESET ioctl, but system hung without any response,
> > > only printed some mesages from kernel(v2.4.20):
> > >
> > > hda: DMA disabled
> > > hda: ide_set_handler: handler not null; old=c01ce300, new=c01d4400
> > > bug: kernel timer added twice at c01ce102
> > >
> > >      would you please help me with it?
> >
> > Does this still occur on 2.4.21pre. It should be fixed now
>
> I had tested 'hdparm -w /dev/hda' under 2.4.21-pre4, but problem sill exist,
>
> just same message as in 2.4.20.
>
> rain.w

Hi Alan,
    I had tested 'hdparm -w /dev/hda' under 2.4.25-pre5-ac1, system
crashed
with
kernel oops message:
    kernel BUG at ide-iops:1046!
    ...

    can this be resolved?

rain.w
