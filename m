Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282213AbRLSSqp>; Wed, 19 Dec 2001 13:46:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282495AbRLSSqf>; Wed, 19 Dec 2001 13:46:35 -0500
Received: from 12-224-36-149.client.attbi.com ([12.224.36.149]:26382 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S282213AbRLSSqQ>;
	Wed, 19 Dec 2001 13:46:16 -0500
Date: Wed, 19 Dec 2001 10:42:53 -0800
From: Greg KH <greg@kroah.com>
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] current state of the 2.5.1 USB tree
Message-ID: <20011219104253.A11032@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Wed, 21 Nov 2001 16:33:22 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Since there has been a bit of development lately in the USB tree, and
I'm holding off in submitting USB changes for a bit to Linus while the
bio stuff stabilizes, I thought I would make a snapshot of my current
tree for the other USB developers to sync up with.

A patch against a clean 2.5.1 tree is at:
	http://www.kroah.com/linux/usb/linux-2.5.1-gregkh-1.patch.gz

This patch contains 5 new USB drivers (stv680, vidcam, ipaq, kl5kusb105,
and the usb 2.0 ehci-hcd driver), documentation for all of these new
drivers, a rewrite of usbdevfs/usbfs, and lots of other smaller fixes
and changes.

If anyone has any questions, problems, or I'm missing any patches that
you have sent to me, please let me know.  (I still have your module
usage patch, Oliver.  I'm waiting for some more discussion before adding
it though.)

And if anyone wants me to post my 2.4 tree (which has most of these same
driver additions), just ask.

thanks,

greg k-h
