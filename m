Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264226AbTDJWxb (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 18:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264227AbTDJWxb (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 18:53:31 -0400
Received: from im1.mail.tds.net ([216.170.230.91]:63966 "EHLO im1.sec.tds.net")
	by vger.kernel.org with ESMTP id S264226AbTDJWxa (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 18:53:30 -0400
Date: Thu, 10 Apr 2003 19:05:02 -0400 (EDT)
From: Jon Portnoy <portnoy@tellink.net>
X-X-Sender: portnoy@cerberus.oppresses.us
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel support for non-english user messages
In-Reply-To: <Pine.LNX.4.53.0304101638010.4978@chaos>
Message-ID: <Pine.LNX.4.53.0304101903280.19136@cerberus.oppresses.us>
References: <3E93A958.80107@si.rr.com> <20030409080803.GC29167@mea-ext.zmailer.org>
 <20030409080803.GC29167@mea-ext.zmailer.org> <20030409190700.H19288@almesberger.net>
 <3E94A1B4.6020602@si.rr.com> <Pine.LNX.4.53.0304092126130.992@chaos>
 <1050001030.12494.1.camel@dhcp22.swansea.linux.org.uk> <shsvfxm157p.fsf@charged.uio.no>
 <Pine.LNX.4.53.0304101638010.4978@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[CC list trimmed, it was getting ridiculous]

On Thu, 10 Apr 2003, Richard B. Johnson wrote:

> On Thu, 10 Apr 2003, Trond Myklebust wrote:
> 
> > >>>>> " " == Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> >
[snip]
> 
> When somebody is writing a driver, if they have any experience,
> they write debugging messages in their native language. But, once
> the driver is written, these debugging messages should be removed
> or #defined out. A properly functioning driver should never complain
> about anything. It shouldn't do anything like you see when you
> execute `dmesg`. The only time you should see information is
> if there's trouble. And trouble with software should be fixed
> immediately so you never have to encounter messages because software
> didn't work. So, you are left will hardware messages like your
> SCSI disk didn't come on-line, or you are out of disk-space.
> For so few messages, you don't need translation, certainly not
> in the kernel. Just Babel-fish it and away you go.
> 

A whole lot of users use dmesg output to figure out if their kernel is 
detecting a piece of hardware. That's a very useful thing to have handy 
and definitely not something that should be yanked out for the sake of 
making it look pretty for people who don't know what they're doing with 
their computer.
