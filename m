Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316594AbSFKAnp>; Mon, 10 Jun 2002 20:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316600AbSFKAno>; Mon, 10 Jun 2002 20:43:44 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:34824 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S316594AbSFKAnm>;
	Mon, 10 Jun 2002 20:43:42 -0400
Date: Mon, 10 Jun 2002 17:40:01 -0700
From: Greg KH <greg@kroah.com>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.21 kill warnings 4/19
Message-ID: <20020611004000.GH5202@kroah.com>
In-Reply-To: <Pine.LNX.4.33.0206082235240.4635-100000@penguin.transmeta.com> <3D048CFD.2090201@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Mon, 13 May 2002 22:08:53 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2002 at 01:26:53PM +0200, Martin Dalecki wrote:
> Fix improper usage of __FUNCTION__ in usb code.

It's not improper.  Well it wasn't when it was written, but the gcc
authors decided to change their minds... :(

As stated before, I'll clean up all of the USB drivers later all at
once, and the pci hotplug drivers as well.  The USB drivers could use
with some good debugging macro cleanup in general...

Martin, any reason you are doing all of this "cleanup" without sending
the patches to the relevant maintainers?

thanks,

greg k-h
