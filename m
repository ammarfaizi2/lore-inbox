Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267543AbTAaBTa>; Thu, 30 Jan 2003 20:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267624AbTAaBTa>; Thu, 30 Jan 2003 20:19:30 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:26462 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S267543AbTAaBT3>; Thu, 30 Jan 2003 20:19:29 -0500
Date: Thu, 30 Jan 2003 20:28:51 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200301310128.h0V1SpL00558@devserv.devel.redhat.com>
To: Wakko Warner <wakko@animx.eu.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB HardDisk Booting 2.4.20
In-Reply-To: <mailman.1043967125.21672.linux-kernel2news@redhat.com>
References: <1043947657.7725.32.camel@steven> <1043952432.31674.22.camel@irongate.swansea.linux.org.uk> <mailman.1043967125.21672.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Is there a reason for not using initrd for this. That should let you
>> use any kind of root device even ones requiring user space work before
>> the real root is mounted.
> 
> Yes, I believe there is.  IMO initrd is too much of an annoyance to setup. 

I believe it's going to be mandatory anyway, perhaps not as initrd,
but as initfs, but the result is the same. Besides, it's not
that big a deal if rpm -i makes initrd for you automagically.

-- Pete
