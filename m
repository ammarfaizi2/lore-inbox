Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965178AbWGJQEq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965178AbWGJQEq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 12:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965182AbWGJQEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 12:04:46 -0400
Received: from terminus.zytor.com ([192.83.249.54]:24494 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S965178AbWGJQEp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 12:04:45 -0400
Message-ID: <44B27A8F.6030105@zytor.com>
Date: Mon, 10 Jul 2006 09:04:31 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
CC: "Antonino A. Daplas" <adaplas@gmail.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg KH <greg@kroah.com>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Clean up old names in tty code to current names
References: <9e4733910607092111i4c41c610u8b9df5b917cca02c@mail.gmail.com>	 <9e4733910607100541i744dd744n16c35c50dae1e98d@mail.gmail.com>	 <1152537049.27368.119.camel@localhost.localdomain>	 <9e4733910607100603r5ae1a21ex1a2fa0f045424fd1@mail.gmail.com>	 <1152539034.27368.124.camel@localhost.localdomain>	 <9e4733910607100707g4810a86boa93a5b6b0b1a8d0a@mail.gmail.com>	 <44B26752.9000507@gmail.com>	 <9e4733910607100757t4ddfaf93l1723580de551529b@mail.gmail.com>	 <1152544746.27368.134.camel@localhost.localdomain>	 <44B273B9.8050308@gmail.com> <9e4733910607100854x250e9d3aga027ef5e156ec34e@mail.gmail.com>
In-Reply-To: <9e4733910607100854x250e9d3aga027ef5e156ec34e@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:
> 
> BSD has /dev/vc/0 right? I suspect that code is there to support BSD
> and make the app portable.
> 

I think it was there to support devfs.

> As far as I know the only time Linux has ever had /dev/vc/0 was during
> the brief excursion into devfs land. At that time /proc/tty/drivers
> was modified to support devfs.  But now devfs has been removed and the
> device has reverted back to tty0. But /proc/tty/drivers wasn't
> adjusted for devfs removal.
> 

Agreed.

	-hpa
