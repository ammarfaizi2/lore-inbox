Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265333AbTAJQEl>; Fri, 10 Jan 2003 11:04:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265339AbTAJQEl>; Fri, 10 Jan 2003 11:04:41 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:21908 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S265333AbTAJQEk>; Fri, 10 Jan 2003 11:04:40 -0500
Date: Fri, 10 Jan 2003 11:13:25 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200301101613.h0AGDP427356@devserv.devel.redhat.com>
To: linux-kernel@vger.kernel.org
cc: Chrissie <x.chrissie.x@t-online.de>
Subject: Re: Oops with usb-mass-storage
In-Reply-To: <mailman.1042201321.19067.linux-kernel2news@redhat.com>
References: <Pine.LNX.4.50.0301091702070.958-100000@balearen.x-tra-designs> <mailman.1042201321.19067.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> i get an kernel oops after following additional output to the console
> 
> An oops? This is *the* first oops, please decode and post it to USB folks.
> Subsequent oopses are of much less help...

I got him to send the decoded oops, but it's the usual
uhci_free_dev => ... => usb_destroy_configuration => kfree
May be fixed in pre3, may be not...

-- Pete
