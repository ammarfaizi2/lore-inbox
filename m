Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261617AbTCOV4L>; Sat, 15 Mar 2003 16:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261618AbTCOV4K>; Sat, 15 Mar 2003 16:56:10 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:3783 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S261617AbTCOV4H>;
	Sat, 15 Mar 2003 16:56:07 -0500
Date: Sat, 15 Mar 2003 23:06:42 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Greg KH <greg@kroah.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org,
       sensors@stimpy.netroedge.com
Subject: Re: [PATCH] i2c driver changes for 2.5.64
Message-ID: <20030315230642.A14115@ucw.cz>
References: <10476033263399@kroah.com> <10476033262095@kroah.com> <20030315104901.A3923@ucw.cz> <20030315214623.GB13446@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030315214623.GB13446@kroah.com>; from greg@kroah.com on Sat, Mar 15, 2003 at 01:46:23PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 15, 2003 at 01:46:23PM -0800, Greg KH wrote:
> On Sat, Mar 15, 2003 at 10:49:01AM +0100, Vojtech Pavlik wrote:
> > On Thu, Mar 13, 2003 at 04:55:00PM -0800, Greg KH wrote:
> > >  static struct pci_driver amd8111_driver = {
> > > -	.name		= "amd8111 smbus 2.0",
> > > +	.name		= "amd8111 smbus",
> > 
> > The 2.0 was quite intentional in the .name, because the 8111 has *two*
> > SMBus busses, one SMBus 1.1 and one SMBus 2.0. This driver is only for
> > the 2.0 SMBus controller.
> 
> Ah, I removed the "2.0" portion because it was larger than the 16
> character limit for pci driver names (it shows up in sysfs garbled if
> it's bigger).
> 
> Would "amd8111 smbus 2" be an ok name?

Yes.

-- 
Vojtech Pavlik
SuSE Labs
