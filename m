Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129061AbQKOGZG>; Wed, 15 Nov 2000 01:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129091AbQKOGY4>; Wed, 15 Nov 2000 01:24:56 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:64260 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129061AbQKOGYi>;
	Wed, 15 Nov 2000 01:24:38 -0500
Message-ID: <3A12251B.7F600351@mandrakesoft.com>
Date: Wed, 15 Nov 2000 00:54:35 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Greg KH <greg@wirex.com>
CC: "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
Subject: Re: Patch(?): linux-2.4.0-test11-pre4/drivers/sound/yss225.c 
 compilefailure
In-Reply-To: <200011150102.RAA00924@adam.yggdrasil.com> <3A121F2B.21DB3265@mandrakesoft.com> <20001114214343.A20546@wirex.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Wed, Nov 15, 2000 at 12:29:15AM -0500, Jeff Garzik wrote:
> > If we are going to create CONFIG_USB_HOTPLUG, we must -eliminate-
> > CONFIG_HOTPLUG, and create CONFIG_PCI_HOTPLUG, and
> > CONFIG_ANOTHERBUS_HOTPLUG and so on, for each hotplug bus.
> 
> Argh!
> I thought the whole point of this was to make there be only one hotplug
> strategy, due to the fact that this is a real need.
> 
> Please let's not go down this path.  It was all starting to look so
> nice...

I -want- there to be only one hotplug strategy, but Adam seemed to be
talking about the opposite, with his CONFIG_USB_HOTPLUG suggestion.

I'm hoping that Linus will disagree with the splintering of
CONFIG_HOTPLUG too...

I think it's too late in 2.4.x cycle to change now anyway.

	Jeff


-- 
Jeff Garzik             |
Building 1024           | The chief enemy of creativity is "good" sense
MandrakeSoft            |          -- Picasso
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
