Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285435AbRLSUFk>; Wed, 19 Dec 2001 15:05:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285440AbRLSUFa>; Wed, 19 Dec 2001 15:05:30 -0500
Received: from 12-224-36-149.client.attbi.com ([12.224.36.149]:37134 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S285435AbRLSUFU>;
	Wed, 19 Dec 2001 15:05:20 -0500
Date: Wed, 19 Dec 2001 12:01:57 -0800
From: Greg KH <greg@kroah.com>
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] current state of the 2.4.17-rc2 USB tree
Message-ID: <20011219120157.A11565@kroah.com>
In-Reply-To: <20011219104253.A11032@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011219104253.A11032@kroah.com>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Wed, 21 Nov 2001 17:58:43 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2001 at 10:42:53AM -0800, Greg KH wrote:
> 
> And if anyone wants me to post my 2.4 tree (which has most of these same
> driver additions), just ask.

Ok, people asked :)

It can be found at:
	http://www.kroah.com/linux/usb/linux-2.4.17-rc2-gregkh-1.patch.gz

I've backported a number of the small 2.5.1 changes into this tree (the
new drivers, and the usb_fill_bulk_*_urb() functions and documentation.)
I haven't backported the USB 2.0 changes here.  If you want to play with
USB 2.0 devices, you have to use the 2.5 tree.

Again, if anyone notices any missing patches that should be in here,
please let me know.

thanks,

greg k-h
