Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287432AbSAHAB5>; Mon, 7 Jan 2002 19:01:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287439AbSAHABr>; Mon, 7 Jan 2002 19:01:47 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:49163 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S287432AbSAHABj>;
	Mon, 7 Jan 2002 19:01:39 -0500
Date: Mon, 7 Jan 2002 15:59:41 -0800
From: Greg KH <greg@kroah.com>
To: David Brownell <david-b@pacbell.net>
Cc: lkml <linux-kernel@vger.kernel.org>, mochel@osdl.org
Subject: Re: Hardware Inventory [was: Re: ISA slot detection on PCI systems?]
Message-ID: <20020107235941.GB10145@kroah.com>
In-Reply-To: <20020107192903.GB8413@kroah.com> <17b801c197ba$febd13c0$6800000a@brownell.org> <20020107220348.GE9271@kroah.com> <17d401c197ca$a78e66c0$6800000a@brownell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17d401c197ca$a78e66c0$6800000a@brownell.org>
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Mon, 10 Dec 2001 21:51:27 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2002 at 02:28:38PM -0800, David Brownell wrote:
> > Hopefully, integration of /sbin/hotplug during the boot process (using
> > dietHotplug) will reduce the number of things the "coldplug" issue will
> > have to handle.
> 
> Somewhat -- though it only handles the "load a module"
> subproblem.  When new devices need any more setup
> than that, "dietHotplug" isn't enough.

Agreed.  dietHotplug doesn't want to solve that problem right now.  I'll
leave that up to the main linux-hotplug scripts :)

greg k-h
