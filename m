Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267472AbTB1E6b>; Thu, 27 Feb 2003 23:58:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267473AbTB1E6b>; Thu, 27 Feb 2003 23:58:31 -0500
Received: from [202.109.126.231] ([202.109.126.231]:62718 "HELO
	www.support-smartpc.com.cn") by vger.kernel.org with SMTP
	id <S267472AbTB1E6a>; Thu, 27 Feb 2003 23:58:30 -0500
Message-ID: <3E5EEDF9.5906D73E@mic.com.tw>
Date: Fri, 28 Feb 2003 13:04:57 +0800
From: "rain.wang" <rain.wang@mic.com.tw>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.21-pre4 i686)
X-Accept-Language: zh, en, zh-TW, zh-CN
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: system hang on HDIO_DRIVE_RESET! help!
References: <3E5CEF17.4C014A4C@mic.com.tw> <1046288652.9837.18.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Feb 2003 05:01:39.0078 (UTC) FILETIME=[7A04E260:01C2DEE6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> On Wed, 2003-02-26 at 16:45, rain.wang wrote:
> > Hi,
> >     I did HDIO_DRIVE_RESET ioctl, but system hung without any response,
> > only printed some mesages from kernel(v2.4.20):
> >
> > hda: DMA disabled
> > hda: ide_set_handler: handler not null; old=c01ce300, new=c01d4400
> > bug: kernel timer added twice at c01ce102
> >
> >      would you please help me with it?
>
> Does this still occur on 2.4.21pre. It should be fixed now

I had tested 'hdparm -w /dev/hda' under 2.4.21-pre4, but problem sill exist,

just same message as in 2.4.20.

rain.w


