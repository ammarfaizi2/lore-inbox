Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262882AbTKPP0e (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 10:26:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262901AbTKPP0d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 10:26:33 -0500
Received: from mail.skjellin.no ([80.239.42.67]:386 "HELO mail.skjellin.no")
	by vger.kernel.org with SMTP id S262882AbTKPP0c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 10:26:32 -0500
Subject: Re: promise 20376
From: Andre Tomt <lkml@tomt.net>
To: linux-kernel@vger.kernel.org
Cc: kashouty@dakotainet.net
In-Reply-To: <3FB78BAF.3060403@dakotainet.net>
References: <3FB78BAF.3060403@dakotainet.net>
Content-Type: text/plain
Message-Id: <1068996385.1448.5.camel@slurv.pasop.tomt.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 16 Nov 2003 16:26:25 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-11-16 at 15:37, merwan kashouty wrote:
> i was just wondering if there was any further progress on a possible 
> native kernel driver for the promise 20376 sata chip... i have it 
> running now but with the proprietary driver from promise's website.... 
> but it seems to work well,
> 
>  Timing buffer-cache reads:   1692 MB in  2.00 seconds = 846.00 MB/sec
>  Timing buffered disk reads:  232 MB in  3.01 seconds =  77.08 MB/sec
> 
> much better then the reported silicon image tests i have seen....  i 
> hope someone is still talking to promise about releasing the full source 
> to get this into the kernel or working to reverse engineer a driver... 
> all the information i have found searching lkml seems to be atleast a 
> couple of months old.

Search again :)

jgarzik's libata supports the promise SATA chips. The support is a
little preliminary still, but it seems to work ok for many.

libata is already merged in 2.6.0-test, and is available as a patch for
2.4 on ftp.kernel.org.

Jeff has also said on the list that promise is cooperating on this open
source driver.

