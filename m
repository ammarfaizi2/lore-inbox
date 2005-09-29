Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751152AbVI2ENZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbVI2ENZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 00:13:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbVI2ENZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 00:13:25 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:18110 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S1751152AbVI2ENY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 00:13:24 -0400
From: kernel-stuff@comcast.net
To: David.Ronis@mcgill.ca
Cc: David Ronis <ronis@ronispc.chem.mcgill.ca>, david.ronis@mcgill.ca,
       linux-kernel@vger.kernel.org
Subject: RE: problem with 2.6.13.[0-2]
Date: Thu, 29 Sep 2005 04:13:23 +0000
Message-Id: <092920050413.11090.433B69E3000AA6AE00002B5222058863609D0E050B9A9D0E99@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Dec 17 2004)
X-Authenticated-Sender: d2FydWRrYXJAY29tY2FzdC5uZXQ=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> In 2.6.13.2:
> 
> /dev/hda:
>  Timing cached reads:    28 MB in  2.15 seconds =  13.03 MB/sec
>  Timing buffered disk reads:   14 MB in  3.30 seconds =   4.24 MB/sec
> 
> and after hdparm -m 16 /dev/hda (recall this is the default in 2.6.12.6)
> 
> /dev/hda:
>  Timing cached reads:    24 MB in  2.05 seconds =  11.73 MB/sec
>  Timing buffered disk reads:   36 MB in  3.11 seconds =  11.56 MB/sec
> 
> I ran thing a few times in each case and the results were close.  There
> was nothing in dmesg.
> 
> David
> 

Hey  that 4.24 MB/sec hints at DMA being busted although it claims to be on. Can you post the complete dmesg output for both kernels please?

Parag



