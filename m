Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289306AbSAIJeV>; Wed, 9 Jan 2002 04:34:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289305AbSAIJeL>; Wed, 9 Jan 2002 04:34:11 -0500
Received: from galba.tp1.ruhr-uni-bochum.de ([134.147.240.75]:43022 "EHLO
	galba.tp1.ruhr-uni-bochum.de") by vger.kernel.org with ESMTP
	id <S289306AbSAIJd6>; Wed, 9 Jan 2002 04:33:58 -0500
Date: Wed, 9 Jan 2002 10:33:57 +0100 (CET)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
To: Greg KH <greg@kroah.com>
cc: <felix-dietlibc@fefe.de>, <linux-kernel@vger.kernel.org>
Subject: Re: initramfs programs (was [RFC] klibc requirements)
In-Reply-To: <20020109043446.GB17655@kroah.com>
Message-ID: <Pine.LNX.4.33.0201091028110.9066-100000@chaos.tp1.ruhr-uni-bochum.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jan 2002, Greg KH wrote:

> On Wed, Jan 09, 2002 at 05:23:31AM +0100, Felix von Leitner wrote:
> > 
> > How many programs are we talking about here?  And what should they do?
> 
> Very good question that we should probably answer first (I'll follow up
> to your other points in a separate message).
> 
> Here's what I want to have in my initramfs:
> 	- /sbin/hotplug
> 	- /sbin/modprobe
> 	- modules.dep (needed for modprobe, but is a text file)
> 
> What does everyone else need/want there?

Provision to mount the real root, i.e.
- mount

Mount the real root via NFS
- ifconfig/dhcpcd/pump
- portmap?

Or did I get that wrong?

--Kai


