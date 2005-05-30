Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261606AbVE3Otw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbVE3Otw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 10:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261615AbVE3Otw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 10:49:52 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:5337 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261606AbVE3Otm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 10:49:42 -0400
From: kernel-stuff@comcast.net (Parag Warudkar)
To: "Michael Sterrett -Mr. Bones.-" <msterret@coat.com>
Cc: Lee Revell <rlrevell@joe-job.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       John Livingston <jujutama@comcast.net>,
       Aleksey Gorelov <Aleksey_Gorelov@Phoenix.com>, gregkh@gentoo.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: How to find if BIOS has already enabled the device
Date: Mon, 30 May 2005 14:49:24 +0000
Message-Id: <053020051449.480.429B27F3000D2CFA000001E0220700095300009A9B9CD3040A029D0A05@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Dec 17 2004)
X-Authenticated-Sender: a2VybmVsLXN0dWZmQGNvbWNhc3QubmV0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Wow, I definitely disagree, considering that the udev maintainer has
> commit privileges for Gentoo.
> 
> Try http://www.gentoo.org/doc/en/udev-guide.xml for help.
> 
> Michael Sterrett
>    -Mr. Bones.-

"Just works" == emerge udev; rc-update add udev boot; reboot 
 -:)! Add "reading a big document" to that and it becomes "works after reading a document" ! 

Well, I had tried the gentoo udev guide, but landed in an non booting system - kernel couldn't mount /dev/hdaX since udev hadn't set it up by then. So I have to add devfs to command line. No offense to udev maintainer or the document writer - the problem might be unique to my setup.

Now going back to my original question - has anyone got an idea as to why pci_enable_device() could hang system for 2 minutes before recovering ;) ?!

Parag



