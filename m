Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262802AbVFVHv7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262802AbVFVHv7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 03:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262823AbVFVHsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 03:48:50 -0400
Received: from dvhart.com ([64.146.134.43]:43185 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S262843AbVFVGkB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 02:40:01 -0400
Date: Tue, 21 Jun 2005 23:40:06 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: "David S. Miller" <davem@davemloft.net>, gregkh@suse.de
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] devfs: remove devfs from Kconfig preventing it from being built
Message-ID: <258190000.1119422406@[10.10.2.4]>
In-Reply-To: <20050621.214527.71091057.davem@davemloft.net>
References: <20050621222419.GA23896@kroah.com><20050621.155919.85409752.davem@davemloft.net><20050622041330.GB27716@suse.de> <20050621.214527.71091057.davem@davemloft.net>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > However, this does mean I do need to reinstall a couple
>> > debian boxes here to something newer before I can continue
>> > doing kernel work in 2.6.x on them.
>> 
>> Those boxes rely on devfs?
> 
> Yeah, when I forget to turn on DEVFS_FS and DEVFS_MOUNT in the
> kernel config the machine won't boot. :-)
> 
>> Can't you just grab the "static dev" debian package and continue on?
>> I'm sure there is one in there somewhere (don't really know for sure,
>> not running debian anywhere here, sorry.)
>> 
>> Or how about a tarball of a /dev tree?  Would that help you out?
> 
> I don't know if Debian has such a package.
> 
> Don't worry, I'll take care of this by simply reinstalling
> and thus moving to udev.

??? I use debian sarge all the time with kernel.org kernels that don't
have devfs compiled in, and I don't use udev either. Works across ia32,
x86_64, and PPC64 (32 bit userspace) at least, with no trouble at all,
out of the box. I did the same with Woody as well before that ...

M.

