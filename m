Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270134AbTGMGaG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 02:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270135AbTGMGaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 02:30:06 -0400
Received: from port-212-202-177-10.reverse.qdsl-home.de ([212.202.177.10]:36624
	"EHLO camelot.fbunet.de") by vger.kernel.org with ESMTP
	id S270134AbTGMGaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 02:30:03 -0400
From: Fridtjof Busse <fridtjof.busse@gmx.de>
To: Greg KH <greg@kroah.com>
Subject: Re: [2.4.22-pre5] usb-storage error
Date: Sun, 13 Jul 2003 08:44:48 +0200
References: <20030713041419.GB2695@kroah.com> <22466.1058078462@www57.gmx.net>
In-Reply-To: <22466.1058078462@www57.gmx.net>
Cc: linux-kernel@vger.kernel.org
X-OS: Linux on i686
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307130844.48337@fbunet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 13 July 2003 08:41, Greg KH wrote:
> > Hi
> > I'm trying to backup files from an ext3-partition via dump. The 
> > backup-drive is an USB 2.0 disk.
> > After a few minutes I get an error (with -pre3 to -pre5):
> > 
> > kernel: usb_control/bulk_msg: timeout
> > kernel: usb_control/bulk_msg: timeout
> > kernel: usb_control/bulk_msg: timeout
> > kernel: usb.c: USB disconnect on device 00:02.2-1 address 2
> 
> Hm, your device disconnected itself, not much the kernel can do about
> that :)

Why should that happen only with 2.4.22-pre* and not with 2.4.21? 
I don't think the drive cares about the kernel-version :)

> How does 2.5 work for you?  It has much better usb-storage support.

2.5 works, but I have still some issues with 2.5, so I don't want to run 
it as my default kernel.
There really seems to be a problem with usb-storage:
<http://sourceforge.net/mailarchive/forum.php?thread_id=2712155&forum_id=5398>

Please CC me, thanks. 

-- 
Fridtjof Busse
# Okay, what on Earth is this one supposed to be used for?
        2.4.0 linux/drivers/char/cp437.uni

