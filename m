Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129057AbQKIGAO>; Thu, 9 Nov 2000 01:00:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129097AbQKIGAF>; Thu, 9 Nov 2000 01:00:05 -0500
Received: from [216.161.55.93] ([216.161.55.93]:8175 "EHLO blue.int.wirex.com")
	by vger.kernel.org with ESMTP id <S129057AbQKIF7w>;
	Thu, 9 Nov 2000 00:59:52 -0500
Date: Wed, 8 Nov 2000 21:59:01 -0800
From: Greg KH <greg@wirex.com>
To: David Ford <david@linux.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [bug] usb-uhci locks up on boot half the time
Message-ID: <20001108215901.A13572@wirex.com>
Mail-Followup-To: Greg KH <greg@wirex.com>, David Ford <david@linux.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3A09F158.910C925@linux.com> <14857.62696.393621.795132@somanetworks.com> <3A09FD81.E7DA9352@linux.com> <20001108200844.A13446@wirex.com> <3A0A25C1.C46E392B@linux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A0A25C1.C46E392B@linux.com>; from david@linux.com on Wed, Nov 08, 2000 at 08:19:13PM -0800
X-Operating-System: Linux 2.4.0-test10 (i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2000 at 08:19:13PM -0800, David Ford wrote:
> I am going thru the steps atm.  The JE driver also hangs.

Thanks for doing this.

> More information.  I have an external USB 4 port hub, in which I have one
> logitech mouse at the moment.  I can cold boot and reboot to my heart's
> delight fine.  But if I unplug/plug in the mouse and reboot, it will hang.
> Note, I have to unplug and plug back in the mouse to get it recognized by
> the system before I can use it.

Is the external hub a externally powered hub, or self powered hub (does
it get it's power from a plug in the wall, or from the USB bus)?  Self
powered hubs are notoriously flaky and have been known to do evil things
to the USB bus.

thanks,

greg k-h

-- 
greg@(kroah|wirex).com
http://immunix.org/~greg
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
