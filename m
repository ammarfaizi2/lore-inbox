Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262667AbSKMSwQ>; Wed, 13 Nov 2002 13:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262664AbSKMSwQ>; Wed, 13 Nov 2002 13:52:16 -0500
Received: from adsl-67-120-62-187.dsl.lsan03.pacbell.net ([67.120.62.187]:9738
	"EHLO exchange.macrolink.com") by vger.kernel.org with ESMTP
	id <S262667AbSKMSwP>; Wed, 13 Nov 2002 13:52:15 -0500
Message-ID: <11E89240C407D311958800A0C9ACF7D1A33CA9@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'Greg KH'" <greg@kroah.com>
Cc: "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: RE: hotplug (was devfs)
Date: Wed, 13 Nov 2002 10:59:07 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, November 13, 2002 at 10:45 AM, Greg KH wrote:
> On Wed, Nov 13, 2002 at 10:45:43AM -0800, Ed Vance wrote:
> > On Wed, November 13, 2002 at 10:05 AM, Greg KH wrote: 
> > > On Wed, Nov 13, 2002 at 06:06:06PM +0000, Nick Craig-Wood wrote:
> > > > 
> > > > So I'll be able to say usb bus1/1/4/1 port 3 should be 
> /dev/ttyUSB15
> > > > and it will always be that port?  That would be perfect.
> > > 
> > > Yes, that is the goal.
> > > 
> > 
> > Do you expect that goal to eventually be applied to 
> CompactPCI Hot-Swap
> > bus/slot port 3?
> 
> Yes, in a round-about way.  If the device that is in that 
> specific slot
> with that specific port, registers with, for example, the network
> subsystem, and we have decided that anything in that slot should be
> called "eth42", then we can do that based on the topology of 
> the device.
> 
> It really depends on the device that is existing in a 
> specific location
> (network, scsi, etc.) and not so much as the specific location will
> always be a network card called "ethX", as you have to look 
> at the type
> of device too.
> 
> Does that make sense?

Yes.
> 
> I can tell it's getting to be the time to start writing all 
> of this down
> for people to hash out... :)
> 

Very cool. 

Thanks,
Ed

---------------------------------------------------------------- 
Ed Vance              edv (at) macrolink (dot) com
Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
----------------------------------------------------------------
