Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129105AbQKLT3A>; Sun, 12 Nov 2000 14:29:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130313AbQKLT2u>; Sun, 12 Nov 2000 14:28:50 -0500
Received: from [216.161.55.93] ([216.161.55.93]:31727 "EHLO blue.int.wirex.com")
	by vger.kernel.org with ESMTP id <S129213AbQKLT2r>;
	Sun, 12 Nov 2000 14:28:47 -0500
Date: Sun, 12 Nov 2000 11:28:19 -0800
From: Greg KH <greg@wirex.com>
To: Gert Wollny <wollny@cns.mpg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test11-pre3: Compile error in drivers/usb/usb.c
Message-ID: <20001112112819.A23154@wirex.com>
Mail-Followup-To: Greg KH <greg@wirex.com>, Gert Wollny <wollny@cns.mpg.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10011122005440.643-100000@bolide.beigert.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10011122005440.643-100000@bolide.beigert.de>; from wollny@cns.mpg.de on Sun, Nov 12, 2000 at 08:08:59PM +0100
X-Operating-System: Linux 2.2.17-immunix (i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 12, 2000 at 08:08:59PM +0100, Gert Wollny wrote:
> compiling usb as module i get: 
> drivers/usb/usb.c 723: hotplug_path unknown ...

Need to select CONFIG_HOTPLUG for USB now.  This will be fixed (one way
or the other) soon.

thanks,

greg k-h

-- 
greg@(kroah|wirex).com
http://immunix.org/~greg
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
