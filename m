Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129091AbQKOHWw>; Wed, 15 Nov 2000 02:22:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129061AbQKOHWm>; Wed, 15 Nov 2000 02:22:42 -0500
Received: from [216.161.55.93] ([216.161.55.93]:25083 "EHLO blue.int.wirex.com")
	by vger.kernel.org with ESMTP id <S129069AbQKOHWZ>;
	Wed, 15 Nov 2000 02:22:25 -0500
Date: Tue, 14 Nov 2000 22:52:01 -0800
From: Greg KH <greg@wirex.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
Subject: Re: Patch(?): linux-2.4.0-test11-pre4/drivers/sound/yss225.c compilefailure
Message-ID: <20001114225201.B20546@wirex.com>
Mail-Followup-To: Greg KH <greg@wirex.com>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	"Adam J. Richter" <adam@yggdrasil.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200011150102.RAA00924@adam.yggdrasil.com> <3A121F2B.21DB3265@mandrakesoft.com> <20001114214343.A20546@wirex.com> <3A12251B.7F600351@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A12251B.7F600351@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Wed, Nov 15, 2000 at 12:54:35AM -0500
X-Operating-System: Linux 2.2.17-immunix (i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2000 at 12:54:35AM -0500, Jeff Garzik wrote:
> 
> I -want- there to be only one hotplug strategy, but Adam seemed to be
> talking about the opposite, with his CONFIG_USB_HOTPLUG suggestion.

Here's Adam's proposal for CONFIG_USB_HOTPLUG:
	http://www.geocrawler.com/lists/3/SourceForge/2571/250/4599696/

>From what I remember (and from looking at this message), all he seems to
want is to redefine the __init and __initdata macros depending on a
config item.  There's no other grander scheme of things, right Adam?

Although such a small memory savings for turning a bus whose main goal
in life is to enable hot plugged devices into a fixed connection doesn't
seem worth it.  

We are talking embedded USB hosts here, not devices.  USB devices
running Linux is a whole 'nother thing, which I'm just now starting to
look into...

Comments Adam?

thanks,

greg k-h

-- 
greg@(kroah|wirex).com
http://immunix.org/~greg
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
