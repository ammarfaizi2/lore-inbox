Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129766AbQKIEJy>; Wed, 8 Nov 2000 23:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129961AbQKIEJm>; Wed, 8 Nov 2000 23:09:42 -0500
Received: from [216.161.55.93] ([216.161.55.93]:44536 "EHLO blue.int.wirex.com")
	by vger.kernel.org with ESMTP id <S129766AbQKIEJe>;
	Wed, 8 Nov 2000 23:09:34 -0500
Date: Wed, 8 Nov 2000 20:08:44 -0800
From: Greg KH <greg@wirex.com>
To: David Ford <david@linux.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [bug] usb-uhci locks up on boot half the time
Message-ID: <20001108200844.A13446@wirex.com>
Mail-Followup-To: Greg KH <greg@wirex.com>, David Ford <david@linux.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3A09F158.910C925@linux.com> <14857.62696.393621.795132@somanetworks.com> <3A09FD81.E7DA9352@linux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A09FD81.E7DA9352@linux.com>; from david@linux.com on Wed, Nov 08, 2000 at 05:27:29PM -0800
X-Operating-System: Linux 2.4.0-test10 (i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2000 at 05:27:29PM -0800, David Ford wrote:
> I just recompiled using the JE driver and it doesn't lock up on boot.

If you have the time, could you please do the debugging steps that Keith
Owens just listed.  It might enable us to determine what is wrong with
the usb-uhci.o driver (the JE driver doesn't work with all devices right
now, so we are still dependent on usb-uhci.o).

thanks,

greg k-h

-- 
greg@(kroah|wirex).com
http://immunix.org/~greg
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
