Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129112AbQKOGOd>; Wed, 15 Nov 2000 01:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129132AbQKOGOW>; Wed, 15 Nov 2000 01:14:22 -0500
Received: from [216.161.55.93] ([216.161.55.93]:26862 "EHLO blue.int.wirex.com")
	by vger.kernel.org with ESMTP id <S129112AbQKOGOJ>;
	Wed, 15 Nov 2000 01:14:09 -0500
Date: Tue, 14 Nov 2000 21:43:43 -0800
From: Greg KH <greg@wirex.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
Subject: Re: Patch(?): linux-2.4.0-test11-pre4/drivers/sound/yss225.c compilefailure
Message-ID: <20001114214343.A20546@wirex.com>
Mail-Followup-To: Greg KH <greg@wirex.com>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	"Adam J. Richter" <adam@yggdrasil.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200011150102.RAA00924@adam.yggdrasil.com> <3A121F2B.21DB3265@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A121F2B.21DB3265@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Wed, Nov 15, 2000 at 12:29:15AM -0500
X-Operating-System: Linux 2.2.17-immunix (i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2000 at 12:29:15AM -0500, Jeff Garzik wrote:
> 
> This is not just a USB issue.  Please discuss this on linux-kernel, so
> we can have a coherent hotplug strategy for the entire kernel.

I agree.  If I see the topic come up on linux-usb-devel again, I'll push
it over to linux-kernel.

> If we are going to create CONFIG_USB_HOTPLUG, we must -eliminate-
> CONFIG_HOTPLUG, and create CONFIG_PCI_HOTPLUG, and
> CONFIG_ANOTHERBUS_HOTPLUG and so on, for each hotplug bus.

Argh!
I thought the whole point of this was to make there be only one hotplug
strategy, due to the fact that this is a real need.

Please let's not go down this path.  It was all starting to look so
nice...

greg k-h

-- 
greg@(kroah|wirex).com
http://immunix.org/~greg
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
