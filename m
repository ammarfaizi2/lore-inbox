Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271825AbRILVpF>; Wed, 12 Sep 2001 17:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271808AbRILVoy>; Wed, 12 Sep 2001 17:44:54 -0400
Received: from smtp-ham-2.netsurf.de ([194.195.64.98]:39929 "EHLO
	smtp-ham-2.netsurf.de") by vger.kernel.org with ESMTP
	id <S271795AbRILVon>; Wed, 12 Sep 2001 17:44:43 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
To: Pavel Machek <pavel@suse.cz>, Phil Thompson <Phil.Thompson@pace.co.uk>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: User Space Emulation of Devices
Date: Wed, 12 Sep 2001 23:45:24 +0200
X-Mailer: KMail [version 1.3]
In-Reply-To: <54045BFDAD47D5118A850002A5095CC30AC57D@exchange1.cam.pace.co.uk> <20010912122826.A6153@bug.ucw.cz>
In-Reply-To: <20010912122826.A6153@bug.ucw.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010912214444Z271795-760+12170@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 12. September 2001 12:28 schrieb Pavel Machek:
> Hi!
>
> > Without going into the gory details, I have a requirement for a device
> > driver that does very little apart from pass on the open/close/read/write
> > "requests" onto a user space application to implement and pass back to
> > the driver.
> >
> > Does anything like this already exist?
>
> Something like that which would also pass ioctl()s would be *very*
> welcome.
> 								Pavel

How do you pass an ioctl ? If any parameter is a pointer you actually need a 
complex protocol for passing memory content to make it useful.

	Regards
		Oliver

