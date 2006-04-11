Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750908AbWDKSlz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750908AbWDKSlz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 14:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750987AbWDKSlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 14:41:55 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:21141 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750899AbWDKSlx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 14:41:53 -0400
Date: Tue, 11 Apr 2006 20:41:42 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Alessandro Suardi <alessandro.suardi@gmail.com>
cc: Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 40% IDE performance regression going from FC3 to FC5 with same
 kernel
In-Reply-To: <5a4c581d0604111104y65f35e68ha9a5ff7e4061a9ea@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0604112040360.25940@yvahk01.tjqt.qr>
References: <5a4c581d0604080747w61464d48k5480391d98b2bc47@mail.gmail.com> 
 <5a4c581d0604080834k7961aff5l7794b8893325a90c@mail.gmail.com> 
 <1144511112.2989.8.camel@laptopd505.fenrus.org> 
 <5a4c581d0604080927g532b6d10y7992d9adb4e63d08@mail.gmail.com> 
 <1144514167.2989.10.camel@laptopd505.fenrus.org> 
 <5a4c581d0604081007t32863bf4n1253ebd8352dbf35@mail.gmail.com> 
 <Pine.LNX.4.61.0604111325140.928@yvahk01.tjqt.qr>
 <5a4c581d0604111104y65f35e68ha9a5ff7e4061a9ea@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Compile a non-initrd kernel and run it with the -b parameter (it's passed
>> to /sbin/init). From that shell, run your speed test. What does it show?
>
>All my kernels are non-initrd (as long as I can do this in Fedora,
> I will do that). How do I pass -b to init ?

Any arguments on the kernel boot command line ("append" in lilo.conf or 
equivalent in grub) are passed down to the master process, as specified by 
the init= boot option, if any (defaults to /sbin/init for non-initrd 
kernels, defaults to /init for initramfs, and defaults to something else 
for initrds).


Jan Engelhardt
-- 
