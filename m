Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751234AbVJ0Q2O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbVJ0Q2O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 12:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbVJ0Q2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 12:28:13 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:33688 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1751234AbVJ0Q2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 12:28:13 -0400
Subject: Re: Kernel Panic + Intel SATA
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: =?ISO-8859-1?Q?M=E1rcio?= Oliveira <moliveira@rhla.com>
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4360E217.7000700@rhla.com>
References: <435FC886.7070105@rhla.com>
	 <Pine.LNX.4.61.0510261523350.6174@chaos.analogic.com>
	 <4360261E.4010202@rhla.com> <436026F2.1030206@rhla.com>
	 <Pine.LNX.4.61.0510270839130.9512@chaos.analogic.com>
	 <1130420072.10604.37.camel@localhost.localdomain>
	 <4360E217.7000700@rhla.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 27 Oct 2005 17:27:57 +0100
Message-Id: <1130430478.17679.0.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >If you are using LVM2 or MD you just need to be sure you have the right
> >config options enabled (the Red Hat src.rpm is a good guide).
> >
> >Alan
> >  
> >
> I'm not using lvm or raid in the /root or the /boot partition. All 
> partitions was made directly in the disk and formated with ext3 file 
> system. I think all needed options was compiled in the new kernel, since 
> I copied the /boot/config-2.6.12-1.1456_FC4 (config file from the kernel 
> that works fine) and compiled the kernel.src.rpm without any 
> modifications in the config file, and it still not working.

You also created a new initrd with mkinitrd ?

