Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267851AbUHKAi2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267851AbUHKAi2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 20:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267846AbUHKAi2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 20:38:28 -0400
Received: from mra02.ex.eclipse.net.uk ([212.104.129.89]:64947 "EHLO
	mra02.ex.eclipse.net.uk") by vger.kernel.org with ESMTP
	id S267851AbUHKAiX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 20:38:23 -0400
From: Ian Hastie <ianh@iahastie.clara.net>
To: Alan Cox <alan@redhat.com>
Subject: Re: IDE hackery: lock fixes and hotplug controller stuff
Date: Wed, 11 Aug 2004 01:36:05 +0100
User-Agent: KMail/1.6.2
Cc: Ian Hastie <ianh@iahastie.clara.net>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
References: <20040810161911.GA10565@devserv.devel.redhat.com> <200408102148.57602.ianh@iahastie.local.net> <20040810210630.GA30906@devserv.devel.redhat.com>
In-Reply-To: <20040810210630.GA30906@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408110136.06137.ianh@iahastie.local.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 Aug 2004 22:06, Alan Cox wrote:
> On Tue, Aug 10, 2004 at 09:48:57PM +0100, Ian Hastie wrote:
> > What do those numbers refer to?  Card model numbers?  On ITE's site I can
> > only see an IT8212F which has RAID and an IT8211F that doesn't.
>
> Product rather than chip numbers I think
>
> > I got my IT8212F card from Novatech.  A generic card with no obviously
> > recognisable name and, IMO anyway, quite a reasonable price.  That is
> > assuming it really does everything that they say it can.
>
> Thanks will investigate. I need to see what happens if I turn the
> firmware bits on with my card and then reboot the microprocessor - see if
> its just bios crippled
>
> > It certainly works quite well in pass through mode. *8)
>
> But it has the raid mode stuff ?

Yes it does.  It's certainly sold as a RAID card and it does have a RAID setup 
menu.  I haven't had the opportunity to use it fully as the discs I needed to 
use on it were already set up for software RAID.  Maybe I'll have a couple 
spare(!) discs to play with if I upgrade to SATA.

It seems that the operation depends on the firmware, or should that be BIOS, 
you load onto the card.  There's this from the IT8212 FAQ, 
http://www.ite.com.tw/faq/it8212.html

1. Could I use IT8212 for CD-ROM? 
Ans:  IT8212 supports either RAID controller (which supports hard drives
only) or pure IDE controller (which supports hard drives and CDROM)
with different BIOS code. Please update your BIOS ROM with ATAPI
BIOS.

There are certainly two files available

http://www.ite.com.tw/pc/bios_8212Raid-093015-02.zip

and

http://www.ite.com.tw/pc/bios_8212ATAPI-093015-02.zip

-- 
Ian.
