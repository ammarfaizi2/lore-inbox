Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129216AbQKBVWg>; Thu, 2 Nov 2000 16:22:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129378AbQKBVW1>; Thu, 2 Nov 2000 16:22:27 -0500
Received: from [216.161.55.93] ([216.161.55.93]:61430 "EHLO blue.int.wirex.com")
	by vger.kernel.org with ESMTP id <S129216AbQKBVWP>;
	Thu, 2 Nov 2000 16:22:15 -0500
Date: Thu, 2 Nov 2000 13:22:06 -0800
From: Greg KH <greg@wirex.com>
To: Sasi Peter <sape@iq.rulez.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.18pre19
Message-ID: <20001102132206.B2424@wirex.com>
Mail-Followup-To: Greg KH <greg@wirex.com>, Sasi Peter <sape@iq.rulez.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10011020931280.8444-100000@iq.rulez.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10011020931280.8444-100000@iq.rulez.org>; from sape@iq.rulez.org on Thu, Nov 02, 2000 at 11:26:18AM +0100
X-Operating-System: Linux 2.4.0-test10 (i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2000 at 11:26:18AM +0100, Sasi Peter wrote:
> Hi!
> 
> Seems like something in USB went wrong from pre15, I get something like
> what is in the attachment.
> 
> I have tried using HID + mouse, HID BP, disabling event interface,
> disabling hot-plug support, disabling  preliminary USB fs, disabling
> bandwidth allocation, the effect are still the same even is leaving there
> only the basic stuff:

Could you send the result of /proc/interrupts and 'lspci -v'?
Also, have you tried the alternate UHCI controller driver?
Or tried USB as modules, instead of compiled in?

thanks,

greg k-h

-- 
greg@(kroah|wirex).com
http://immunix.org/~greg
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
