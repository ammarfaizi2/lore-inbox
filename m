Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267500AbTBLSiE>; Wed, 12 Feb 2003 13:38:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267524AbTBLSiE>; Wed, 12 Feb 2003 13:38:04 -0500
Received: from [81.2.122.30] ([81.2.122.30]:9476 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S267500AbTBLSiD>;
	Wed, 12 Feb 2003 13:38:03 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200302121848.h1CImUUg017443@darkstar.example.net>
Subject: Re: support for dual independent keyboards in devel kernel?
To: jsimmons@infradead.org (James Simmons)
Date: Wed, 12 Feb 2003 18:48:30 +0000 (GMT)
Cc: rick@sapphire.no-ip.com, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0302121833480.31435-100000@phoenix.infradead.org> from "James Simmons" at Feb 12, 2003 06:40:01 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I have been doing some research on running 2 independent displays
> > off of 1 machine (ie 2 keyboards, 2 mice, 2 vid cards, 2
> > monitors).. there are some hacks out there now that "sort of"
> > work.... but nothing stable and official..   
> > it's all hacks....   I have read that support for this is planned
> > for 2.5/2.6, and would like to know what progress has been done.
> > I am willing to help where I can.  I am a good C/C++ programmer,
> > but have not done any kernel work so far.
> 
>    You are talking about the linuxconsole project. Yes with alot of work 
> we got a multi-desktop system working. We even got several X servers with 
> several patches running on different desktops even tho they where working 
> out of one box. The main problem with this research was the console system 
> level of code was intertwine in each input and display driver. In 2.5.X 
> you see the moving of the console keyboards etc to the input api which can 
> function indepenedent of the console layer. You also had the same effect 
> with the new framebuffer layer. This was done to make driver writing easy 
> and to help the embedded space as well as prepare for the future 
> multi-desktop of linux. 

There was a thread some months ago, called something like 'Linux as a
minicomputer', where we discussed this kind of thing.

John.
