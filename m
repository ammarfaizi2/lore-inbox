Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289887AbSBKRrg>; Mon, 11 Feb 2002 12:47:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289972AbSBKRrV>; Mon, 11 Feb 2002 12:47:21 -0500
Received: from nat-pool-meridian.redhat.com ([12.107.208.200]:41298 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S289954AbSBKRqh>; Mon, 11 Feb 2002 12:46:37 -0500
Date: Mon, 11 Feb 2002 12:46:36 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200202111746.g1BHkar11371@devserv.devel.redhat.com>
To: weber@nyc.rr.com, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.4 Sound Driver Problem
In-Reply-To: <mailman.1013448601.14957.linux-kernel2news@redhat.com>
In-Reply-To: <mailman.1013448601.14957.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am using the YMFPCI driver on a Toshiba Tecra 8100.
> 
> The sound_alloc_dmap() function in dmabuf.c must be changed from using 
> __get_free_pages() and virt_to_bus() -> pci_alloc_consistent().

What the hell are you talking about, I changed it long ago.
Linus uses ymfpci on his Crusoe Picturebook with no problems.
What is your kernel version?

-- Pete
