Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261389AbTCGF5b>; Fri, 7 Mar 2003 00:57:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261390AbTCGF5b>; Fri, 7 Mar 2003 00:57:31 -0500
Received: from [202.109.126.231] ([202.109.126.231]:45580 "HELO
	www.support-smartpc.com.cn") by vger.kernel.org with SMTP
	id <S261389AbTCGF53>; Fri, 7 Mar 2003 00:57:29 -0500
Message-ID: <3E683663.EBD184A4@mic.com.tw>
Date: Fri, 07 Mar 2003 14:04:19 +0800
From: "rain.wang" <rain.wang@mic.com.tw>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: system hang on HDIO_DRIVE_RESET! help!
References: <3E5CEF17.4C014A4C@mic.com.tw>
		 <1046288652.9837.18.camel@irongate.swansea.linux.org.uk>
		 <3E5EEDF9.5906D73E@mic.com.tw>  <3E64A8A5.4EBB5FB3@mic.com.tw> <1046791639.10857.12.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Mar 2003 06:00:45.0109 (UTC) FILETIME=[E4828650:01C2E46E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> On Tue, 2003-03-04 at 13:22, rain.wang wrote:
> >     I had tested 'hdparm -w /dev/hda' under 2.4.25-pre5-ac1, system
> > crashed
> > with
> > kernel oops message:
> >     kernel BUG at ide-iops:1046!
> >     ...
> >
> >     can this be resolved?
>
> Once I understand what the problems all are yes. The BUG() is good, it
> confirms that what we are both seeing is the same thing - the reset is
> managing to issue two commands to the controller at the same time.

Hi,
    thank you, Alan. I tested pre5-ac2 patch and that seems all ok.

rain.w

