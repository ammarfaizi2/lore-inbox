Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262752AbSI1JVU>; Sat, 28 Sep 2002 05:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262757AbSI1JVU>; Sat, 28 Sep 2002 05:21:20 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:9467 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262752AbSI1JVU>; Sat, 28 Sep 2002 05:21:20 -0400
Subject: Re: System very unstable
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Felix Seeger <felix.seeger@gmx.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200209281115.19968.felix.seeger@gmx.de>
References: <200209281115.19968.felix.seeger@gmx.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 28 Sep 2002 10:32:26 +0100
Message-Id: <1033205547.17777.13.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> EIP:    0010:[get_new_inode+94/368]    Tainted: P
> EFLAGS: 00010206
> eax: f1ec9808   ebx: 00000000   ecx: c1376130 edx: c3761dc8
>
You appear to have some non typical modules loaded. If they are binary
ones from people like Nvidia please see if the box is stable without
them ever being loaded.

If its only just begun happening and you didnt change these modules or
the kernel then it may well be worth checking CPU temperature in the
BIOS, the fans and/or running memtest86 to see if it is hardware.

If you've changed kernel obviously see if the old one works reliably
first

