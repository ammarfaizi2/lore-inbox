Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136161AbRAGRgI>; Sun, 7 Jan 2001 12:36:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136162AbRAGRf6>; Sun, 7 Jan 2001 12:35:58 -0500
Received: from [216.161.55.93] ([216.161.55.93]:12023 "EHLO blue.int.wirex.com")
	by vger.kernel.org with ESMTP id <S136161AbRAGRfy>;
	Sun, 7 Jan 2001 12:35:54 -0500
Date: Sun, 7 Jan 2001 09:37:11 -0800
From: Greg KH <greg@kroah.com>
To: Nicolas Mailhot <Nicolas.Mailhot@email.enst.fr>
Cc: mdharm-usb@one-eyed-alien.net, linux-usb-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, jerdfelt@valinux.com
Subject: Re: [Patch] [linux-2.4.0] drivers/usb/Config.in
Message-ID: <20010107093711.A2748@wirex.com>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	Nicolas Mailhot <Nicolas.Mailhot@email.enst.fr>,
	mdharm-usb@one-eyed-alien.net,
	linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	jerdfelt@valinux.com
In-Reply-To: <20010107140440.E1468@rousalka.maisel2.rezel.enst.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010107140440.E1468@rousalka.maisel2.rezel.enst.fr>; from Nicolas.Mailhot@email.enst.fr on Sun, Jan 07, 2001 at 02:04:40PM +0100
X-Operating-System: Linux 2.4.0-prerelease (i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 07, 2001 at 02:04:40PM +0100, Nicolas Mailhot wrote:
> [Re-send without the mime stuff, sorry about this one]
> 
> Hi,
> 
>  Here is a patchlet to stop people searching for the
> mysteriously hidden USB Mass Storage driver (in case they
> didn't make the connection with SCSI at once like me).

I wouldn't recommend this one.  If you do this, should we do the same
for all of the other dependencies in the USB config section?  Like
VIDEO, SOUND, and others?  That would make for a _big_ mess.

greg k-h

-- 
greg@(kroah|wirex).com
http://immunix.org/~greg
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
