Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315427AbSFTT4d>; Thu, 20 Jun 2002 15:56:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315440AbSFTT4c>; Thu, 20 Jun 2002 15:56:32 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:2576 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S315334AbSFTT4b>;
	Thu, 20 Jun 2002 15:56:31 -0400
Date: Thu, 20 Jun 2002 12:55:05 -0700
From: Greg KH <greg@kroah.com>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Martin Schwenke <martin@meltin.net>, Kurt Garloff <garloff@suse.de>,
       Linux kernel list <linux-kernel@vger.kernel.org>,
       Linux SCSI list <linux-scsi@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: [PATCH] /proc/scsi/map
Message-ID: <20020620195504.GJ32698@kroah.com>
References: <200206200711.RAA10165@thucydides.inspired.net.au> <Pine.LNX.4.44.0206200800260.8012-100000@home.transmeta.com> <20020620165553.GA16897@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020620165553.GA16897@win.tue.nl>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Thu, 23 May 2002 17:33:42 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2002 at 06:55:53PM +0200, Andries Brouwer wrote:
> USB device 0000:0000
> figure out some name...

<snip>

Heh, this is the first time anyone has ever reported those names to me.
Yes, the names aren't very useful yet, but give us time, patches gladly
accepted to fix this :)

The physical representation of the USB trees within the PCI tree is
(imho) a _vast_ improvement over anything we have had before, and that
is currently working quite well.

Now to hook up the USB bus code to the struct bus_type style code, like
PCI now is...

thanks,

greg k-h
