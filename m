Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267468AbTBLSaP>; Wed, 12 Feb 2003 13:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267487AbTBLSaP>; Wed, 12 Feb 2003 13:30:15 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:36113 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267468AbTBLSaO>; Wed, 12 Feb 2003 13:30:14 -0500
Date: Wed, 12 Feb 2003 18:40:01 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Rick Warner <rick@sapphire.no-ip.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: support for dual independent keyboards in devel kernel?
In-Reply-To: <200301251714.07510.rick@sapphire.no-ip.com>
Message-ID: <Pine.LNX.4.44.0302121833480.31435-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I have been doing some research on running 2 independent displays off of 1 
> machine (ie 2 keyboards, 2 mice, 2 vid cards, 2 monitors).. there are some 
> hacks out there now that "sort of" work.... but nothing stable and official.. 
> it's all hacks....   I have read that support for this is planned for 
> 2.5/2.6, and would like to know what progress has been done.  I am willing to 
> help where I can.  I am a good C/C++ programmer, but have not done any kernel 
> work so far.

   You are talking about the linuxconsole project. Yes with alot of work 
we got a multi-desktop system working. We even got several X servers with 
several patches running on different desktops even tho they where working 
out of one box. The main problem with this research was the console system 
level of code was intertwine in each input and display driver. In 2.5.X 
you see the moving of the console keyboards etc to the input api which can 
function indepenedent of the console layer. You also had the same effect 
with the new framebuffer layer. This was done to make driver writing easy 
and to help the embedded space as well as prepare for the future 
multi-desktop of linux. 
   What has not been done is true multi-desktop support. I like to work on 
this in the future but due to recent events in my life I have to abandon 
such research :-(

