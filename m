Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261667AbVB1QHJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261667AbVB1QHJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 11:07:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261668AbVB1QHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 11:07:08 -0500
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:16594 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP id S261667AbVB1QGo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 11:06:44 -0500
X-ORBL: [68.250.202.199]
Date: Mon, 28 Feb 2005 11:06:12 -0500 (EST)
From: Vladimir Dergachev <volodya@mindspring.com>
X-X-Sender: volodya@node2.an-vo.com
Reply-To: Vladimir Dergachev <volodya@mindspring.com>
To: Pavel Machek <pavel@ucw.cz>
cc: Jon Smirl <jonsmirl@gmail.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Alex Deucher <alexdeucher@gmail.com>, Dave Airlie <airlied@linux.ie>,
       dri-devel@lists.sourceforge.net,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       xorg@lists.freedesktop.org
Subject: Re: POSTing of video cards (WAS: Solo Xgl..)
In-Reply-To: <20050228143626.GB1429@elf.ucw.cz>
Message-ID: <Pine.LNX.4.62.0502281051350.28870@node2.an-vo.com>
References: <21d7e997050220150030ea5a68@mail.gmail.com>
 <9e4733910502201542afb35f7@mail.gmail.com> <1108973275.5326.8.camel@gaston>
 <9e47339105022111082b2023c2@mail.gmail.com> <1109019855.5327.28.camel@gaston>
 <9e4733910502211717116a4df3@mail.gmail.com> <1109041968.5412.63.camel@gaston>
 <a728f9f9050221205634a3acf0@mail.gmail.com> <1109049217.5412.79.camel@gaston>
 <9e4733910502212203671eec73@mail.gmail.com> <20050228143626.GB1429@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 28 Feb 2005, Pavel Machek wrote:

> Hi!
>
>>> I think that the driver is the "chief" here and the one to know what to
>>> do with the cards it drives. It can detect a non-POSTed card and deal
>>> with it.
>>
>> What about the x86 case of VGA devices that run without a driver being
>> loaded? Do we force people to load an fbdev driver to get the reset?
>> The BIOS deficiency strategy works for these devices.
>
> Yes, I think we do force people to load fbdev...
>
> ...because different BIOSes will be broken in slightly different ways,
> and you'll probably need to know which BIOS you are trying to load...

I agree. For example, on my Dell notebook the graphics card is not 
reinitialized properly on return from resume. At some point I'll get 
bothered enough to write code that does it.

                         best

                           Vladimir Dergachev
