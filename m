Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267773AbTB1NXv>; Fri, 28 Feb 2003 08:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267829AbTB1NXv>; Fri, 28 Feb 2003 08:23:51 -0500
Received: from [202.109.126.231] ([202.109.126.231]:10021 "HELO
	www.support-smartpc.com.cn") by vger.kernel.org with SMTP
	id <S267773AbTB1NXt>; Fri, 28 Feb 2003 08:23:49 -0500
Message-ID: <3E5F646C.46AB022A@mic.com.tw>
Date: Fri, 28 Feb 2003 21:30:20 +0800
From: "rain.wang" <rain.wang@mic.com.tw>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: zh, en, zh-TW, zh-CN
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: system hang on HDIO_DRIVE_RESET! help!
References: <3E5CEF17.4C014A4C@mic.com.tw>
		 <1046288652.9837.18.camel@irongate.swansea.linux.org.uk>
		 <3E5EEDF9.5906D73E@mic.com.tw> <1046439323.16779.16.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Feb 2003 13:26:56.0234 (UTC) FILETIME=[1073C4A0:01C2DF2D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> On Fri, 2003-02-28 at 05:04, rain.wang wrote:
> > > Does this still occur on 2.4.21pre. It should be fixed now
> >
> > I had tested 'hdparm -w /dev/hda' under 2.4.21-pre4, but problem sill exist,
> >
> > just same message as in 2.4.20.
>
> What controller are you using and I'll look into it a bit further

Intel 82801AA host controller,  and I found when I disabled DMA before doing
drive reset, system wouldn't hang at most time.  It seemed not tight related with

host chip, does it?

rain.w


