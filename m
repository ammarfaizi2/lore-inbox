Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287254AbSAGWGC>; Mon, 7 Jan 2002 17:06:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287256AbSAGWFx>; Mon, 7 Jan 2002 17:05:53 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:36107 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S287254AbSAGWFq>;
	Mon, 7 Jan 2002 17:05:46 -0500
Date: Mon, 7 Jan 2002 14:03:49 -0800
From: Greg KH <greg@kroah.com>
To: David Brownell <david-b@pacbell.net>
Cc: lkml <linux-kernel@vger.kernel.org>, mochel@osdl.org
Subject: Re: Hardware Inventory [was: Re: ISA slot detection on PCI systems?]
Message-ID: <20020107220348.GE9271@kroah.com>
In-Reply-To: <20020107192903.GB8413@kroah.com> <17b801c197ba$febd13c0$6800000a@brownell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17b801c197ba$febd13c0$6800000a@brownell.org>
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Mon, 10 Dec 2001 19:08:53 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2002 at 12:36:32PM -0800, David Brownell wrote:
> 
> It's too early, the system isn't "hot" yet ... which is why I call this
> problem the "coldplug" issue.   Even simple device setup
> operations like modprobing may not be possible, much less
> more complex ones like alerting/starting daemons.  So the
> init.d/hotplug script, invoked later, fakes hotplug events to
> make sure the same setup gets done, without requiring users
> to unplug/replug devices.

Hopefully, integration of /sbin/hotplug during the boot process (using
dietHotplug) will reduce the number of things the "coldplug" issue will
have to handle.

greg k-h
