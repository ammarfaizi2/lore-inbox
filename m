Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278143AbRJXD0V>; Tue, 23 Oct 2001 23:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278273AbRJXD0M>; Tue, 23 Oct 2001 23:26:12 -0400
Received: from [212.113.174.249] ([212.113.174.249]:5155 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id <S278143AbRJXD0C>;
	Tue, 23 Oct 2001 23:26:02 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ricardo Ferreira <stormlabs@gmx.net>
To: Tim Hockin <thockin@sun.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: HPT370/366 testers needed
Date: Wed, 24 Oct 2001 04:26:27 +0100
X-Mailer: KMail [version 1.3.5]
In-Reply-To: <3BD5A007.C07388ED@sun.com>
In-Reply-To: <3BD5A007.C07388ED@sun.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <EXCH01SMTP01op3wyv900060652@smtp.netcabo.pt>
X-OriginalArrivalTime: 24 Oct 2001 03:23:27.0638 (UTC) FILETIME=[3F357B60:01C15C3B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 23 October 2001 17:51, Tim Hockin wrote:
> All,
>
> We have this (attached) large patch for the HighPoint driver.
> Specifically, it deals with HPT370 controllers, and should make them MUCH
> more stable (Adrian spent weeks on the phone with HighPoint).
>
> What I'd like is for people to test this patch on other systems with
> HighPoint 370 controllers.  Also, I need people with HPT366 chips to test,
> and find any problems - we don't have HPT366 here to test.
>
> Volunteers?

Ok, i applied it to my 2.4.12 (no patches besides these) kernel. I never had 
any stability problems with the HPT so the value of my testing might be 
limited. For what its worth, i didn't notice any degradation in performance 
or any other unwanted effects. I also applied the ide-pci.c patch mentioned 
on another thread. I was triyng (and still am) to fix the CoD !=0 in 
idescsi_pc_intr message that always ruins my cd burning efforts. But that 
apparently is not related to the HPT because it also happens on my Promise 
ULTRA66. The only controller who doesn't do this is the VIA onboard 
controller.

PS: HW Info: Abit VP6 2x PIII-1GHz 1GB SDRAM
PS2: You wouldn't by any chance know what that CoD !=0 msg means ?

-- 
[------------------------------------------------][-------------------------]
|"One World, One Web, One Program" - Microsoft Ad||    stormlabs@gmx.net    |
|"Ein Volk, Ein Reich, Ein Fuhrer" - Adolf Hitler||http://storm.superzip.net|
[------------------------------------------------][-------------------------]
       --> thor up 2 days | sentinel up 59 days | loki up 59 days <--
