Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131412AbRCWULL>; Fri, 23 Mar 2001 15:11:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131413AbRCWULC>; Fri, 23 Mar 2001 15:11:02 -0500
Received: from gwyn.tux.org ([207.96.122.8]:17617 "EHLO gwyn.tux.org")
	by vger.kernel.org with ESMTP id <S131412AbRCWUKs>;
	Fri, 23 Mar 2001 15:10:48 -0500
Date: Fri, 23 Mar 2001 15:09:58 -0500 (EST)
From: Joel Gallun <joel@tux.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: raw access and qlogic isp device driver?
In-Reply-To: <E14gUgZ-00050U-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.30.0103231507470.20189-100000@gwyn.tux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Mar 2001, Alan Cox wrote:

> > I'm trying to use Stephen Tweedie's raw device support to access disks
> > attached to a Qlogic ISP 1040/B controller and kernel oopses.
>
> 2.2 or 2.4 ?

2.4.2

> > Has anyone used the raw device with qlogicisp driver? Does anyone have any
> > interest in looking at this?
>
> It shouldnt matter which driver is involved, but 2.4 raw stuff is reported
> broken still

We've used raw with the compaq smart2 and symbios 53c8xx drivers without
problems on 2.4.2, but shortly after we touch a raw device over top of the
qlogicisp we get an oops.

Joel

