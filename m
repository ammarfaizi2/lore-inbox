Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317951AbSFNQlE>; Fri, 14 Jun 2002 12:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317952AbSFNQlD>; Fri, 14 Jun 2002 12:41:03 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:43281 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317951AbSFNQlD>;
	Fri, 14 Jun 2002 12:41:03 -0400
Date: Fri, 14 Jun 2002 09:40:46 -0700
From: Greg KH <greg@kroah.com>
To: Jonas Diemer <diemer@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: insmod stall
Message-ID: <20020614164046.GA27291@kroah.com>
In-Reply-To: <20020614131505.00004803.diemer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Fri, 17 May 2002 15:36:54 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2002 at 01:15:05PM +0200, Jonas Diemer wrote:
> Hi!
> 
> I have a recent debian woody. I want to use the fritz card usb. I
> downloaded and compiled it (its distributed partly binary, part source).
> Usign the debian kernel-image-2.4.18-686, the driver worked. Now I have
> compiled my own kernel (2.4.18 too). Now, the driver doesn't work
> anymore (although I recompiled it against my new kernel sources): when I
> insmod it, I see the messages that appeared with the woody kernel, lsmod
> shows the module, but insmod doesn't exit (i.e. it's listed when i run
> "ps ax" as running (Status R)). when I kill that process, the cpu load
> rises. top shows a process named fcusb_init (if I remember correctly)
> taking 99% of the cpu time.
> 
> What's going wrong here? Have I forgotten something? how come the driver
> worked with the woody kernel and wouldn't work with a self compiled one?

As that driver is a binary driver, you will have to ask the authors of
it, we can't really help you out here.

Good luck,

greg k-h
