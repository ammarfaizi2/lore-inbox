Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161278AbWGJAbc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161278AbWGJAbc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 20:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161281AbWGJAbc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 20:31:32 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:25836
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1161278AbWGJAbc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 20:31:32 -0400
Date: Sun, 09 Jul 2006 17:32:12 -0700 (PDT)
Message-Id: <20060709.173212.112177014.davem@davemloft.net>
To: akpm@osdl.org
Cc: efault@gmx.de, linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: 2.6.18-rc1-mm1: /sys/class/net/ethN becoming symlink befuddled
 /sbin/ifup
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060709135148.60561e69.akpm@osdl.org>
References: <20060709021106.9310d4d1.akpm@osdl.org>
	<1152469329.9254.15.camel@Homer.TheSimpsons.net>
	<20060709135148.60561e69.akpm@osdl.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>
Date: Sun, 9 Jul 2006 13:51:48 -0700

 ...
> > As $subject says, up-to-date SuSE 10.0 /sbin/ifup became confused...
 ...
> I'd be suspecting
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc1/2.6.18-rc1-mm1/broken-out/gregkh-driver-network-class_device-to-device.patch.

Oh well, it means we can't apply that patch as it does break
things.

Greg, do you test on SuSE installations? :-)
