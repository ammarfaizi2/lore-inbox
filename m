Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289355AbSA1UBP>; Mon, 28 Jan 2002 15:01:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289362AbSA1T5s>; Mon, 28 Jan 2002 14:57:48 -0500
Received: from nat-pool-meridian.redhat.com ([12.107.208.200]:53099 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S289365AbSA1T4S>; Mon, 28 Jan 2002 14:56:18 -0500
Date: Mon, 28 Jan 2002 14:56:17 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200201281956.g0SJuH725438@devserv.devel.redhat.com>
To: mrproper@ximian.com, linux-kernel@vger.kernel.org
Subject: Re: Ethernet data corruption?
In-Reply-To: <mailman.1012246740.9237.linux-kernel2news@redhat.com>
In-Reply-To: <mailman.1012246740.9237.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	The other night, my friend was sending me a video over the internet. 
> We tried http, ftp, and other protocols, using different download
> applications.  It seemed to be corrupt, the same way, everytime.  It
> wouldn't work, and had a different md5sum than the "good" version on my
> friend's computer.  Eventually we got it working.
>[...]

Two things are likely:

1. a firewall mangles your TCP streams

2. something is wrong between the driver and the NIC.

-- Pete
