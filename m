Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935588AbWK2Nwf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935588AbWK2Nwf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 08:52:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935596AbWK2Nwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 08:52:35 -0500
Received: from mailer.gwdg.de ([134.76.10.26]:48306 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S935588AbWK2Nwe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 08:52:34 -0500
Date: Wed, 29 Nov 2006 14:52:17 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: prajakta choudhari <prajaktachoudhari@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Help for kernel module programming
In-Reply-To: <Pine.LNX.4.61.0611291012500.3813@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.61.0611291446320.14310@yvahk01.tjqt.qr>
References: <e9010580611282358p5966357cxf50c650819ba1710@mail.gmail.com>
 <Pine.LNX.4.61.0611291012500.3813@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> I am writing a kernel module for assging an ip address to an interface.
>> I  have included linux/igmp.h but still whenever i use the function
>
>...What function?
>
>> declared in  igmp.h file, it says unresolved symbol for that function.
>
>...What symbol?
>
>> I am new to this programming.
>> i use the following command to compile it:
>> gcc -c -D__KERNEL__   -DMODULE
>> -I/home/newkernelsource/linux-2.4.22/include  hello.c
>
>Please read the files in Documentation/kbuild/.

Sorry, was not seeing you use 2.4.x. But the procedure is similar, e.g.
http://ttyrpld.svn.sourceforge.net/viewvc/ttyrpld/trunk/k_linux-2.4/Makefile?revision=2&view=markup


	-`J'
-- 
