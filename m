Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263350AbTC0SJv>; Thu, 27 Mar 2003 13:09:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263353AbTC0SJv>; Thu, 27 Mar 2003 13:09:51 -0500
Received: from jessie.softnet.si ([212.103.128.68]:44184 "EHLO softnet.si")
	by vger.kernel.org with ESMTP id <S263350AbTC0SJv>;
	Thu, 27 Mar 2003 13:09:51 -0500
Date: Thu, 27 Mar 2003 19:21:10 +0100
From: Damjan Bole <damjanbole@gmx.net>
To: Martin Zwickel <martin.zwickel@technotrend.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21pre6: usb ports/mouse not detected
Message-Id: <20030327192110.14d6bf9c.damjanbole@gmx.net>
In-Reply-To: <20030327142101.6a414743.martin.zwickel@technotrend.de>
References: <20030327130546.1f1d6d1f.damjanbole@gmx.net>
	<20030327142101.6a414743.martin.zwickel@technotrend.de>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, my mistake. I forgot to load hid.o which needed keybdev.o. Probably that's why it didn't work when compiled in kernel. Seems like pre6 needs both keybord and mouse input core support.

On Thu, 27 Mar 2003 14:21:01 +0100
Martin Zwickel <martin.zwickel@technotrend.de> wrote:

> On Thu, 27 Mar 2003 13:05:46 +0100
> Damjan Bole <damjanbole@gmx.net> bubbled:
> 
> > Hi
> > 
> > Switching from 2.4.21pre5 to pre6 I've found out my usb mouse is
> > dead and no usb port is detected on my msi kt266pro2. I used same
> > (make oldconfig) as in pre5. I included dmesg logs below. regards
> 
> I had the same problem few hours ago.
> Loading usb-ohci/ehci-hcd as a module fixed it for me ...
> But it's just a "It Works for Me(tm)" ...
