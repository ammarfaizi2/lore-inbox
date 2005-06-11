Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261726AbVFKQcS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261726AbVFKQcS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 12:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261727AbVFKQcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 12:32:18 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:28625 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261726AbVFKQcI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 12:32:08 -0400
Date: Sat, 11 Jun 2005 18:31:59 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Robert Hancock <hancockr@shaw.ca>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 'hello world' module
In-Reply-To: <42AB107B.3030203@shaw.ca>
Message-ID: <Pine.LNX.4.61.0506111830150.19655@yvahk01.tjqt.qr>
References: <4egz4-2tj-15@gated-at.bofh.it> <42AB107B.3030203@shaw.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> 2.4.31, GCC 3.4.4
>> 
>> Build like:
>> 
>> gcc -D__KERNEL__ -I/usr/src/linux/include -DMODULE -Wall -O2 -c hello.c -o
>> hello.o
>
> That compilation method will not work on 2.6. You have to use the kernel
> makefiles to build the module. See:
>
> http://linuxdevices.com/articles/AT4389927951.html

Time for URLs - http://jengelh.hopto.org/linux/krn_buildenv.php
The best, is of course, working examples like jengelh.hopto.org/f/oops_ko.tbz2 
as suggested in that php url. Though, instead of saying hello world, 
the oops_ko sample mods fault on you. :-)



Jan Engelhardt                                                               
--                                                                            
| Gesellschaft fuer Wissenschaftliche Datenverarbeitung Goettingen,
| Am Fassberg, 37077 Goettingen, www.gwdg.de
