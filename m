Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267979AbUJCPvO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267979AbUJCPvO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 11:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267978AbUJCPvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 11:51:14 -0400
Received: from pimout7-ext.prodigy.net ([207.115.63.58]:15605 "EHLO
	pimout7-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S267979AbUJCPvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 11:51:04 -0400
Date: Sun, 3 Oct 2004 11:50:50 -0400 (EDT)
From: Vladimir Dergachev <volodya@mindspring.com>
X-X-Sender: volodya@node2.an-vo.com
Reply-To: Vladimir Dergachev <volodya@mindspring.com>
To: Jon Smirl <jonsmirl@gmail.com>
cc: Dave Airlie <airlied@linux.ie>, dri-devel@lists.sourceforge.net,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Merging DRM and fbdev
In-Reply-To: <9e4733910410030833e8a6683@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0410031145560.17248@node2.an-vo.com>
References: <9e47339104100220553c57624a@mail.gmail.com> 
 <Pine.LNX.4.58.0410030824280.2325@skynet> <9e4733910410030833e8a6683@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 3 Oct 2004, Jon Smirl wrote:

> If we could all just concentrate on fixing the radeondrm driver we
> could build a complete driver for the radeon cards instead of the ten
> half finished ones we have today. Once we get a complete driver the
> incentive for people to write new ones will be gone.



> My model....
>
> radeon - attached to hardware
>   drm - library
>   fb - library
>      fbcon - library

Can we add to this "km" library ? (That's the GATOS v4l module)

In particular, I can contribute the code that does Framebuffer->System Ram
transfers over PCI/AGP. It is currently GPL licensed, but there is no 
problem if BSD folks want it too.

This is also potentially useful for any Mesa functions that want to 
transfer data back from video RAM - using plain reads for this is really slow.

                           best

                              Vladimir Dergachev
