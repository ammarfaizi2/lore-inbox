Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265225AbSJRT3e>; Fri, 18 Oct 2002 15:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265248AbSJRT3e>; Fri, 18 Oct 2002 15:29:34 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:26399 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S265225AbSJRT33>;
	Fri, 18 Oct 2002 15:29:29 -0400
Date: Fri, 18 Oct 2002 21:35:23 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Ed Tomlinson <tomlins@cam.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: usb storage sddr09
Message-ID: <20021018193523.GA25316@win.tue.nl>
References: <200210172155.49349.tomlins@cam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210172155.49349.tomlins@cam.org>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2002 at 09:55:49PM -0400, Ed Tomlinson wrote:

> In the patch fest in the last couple of days usb storage support for sddr09 
> has broken.  I see the following in the log (2.5.43-mm2):

> Oct 17 21:37:07 oscar kernel: sddr09: Found Flash card, ID = 00 00 00 00: Manuf. unknown, 4096 MB
> Oct 17 21:37:07 oscar kernel: sda : unsupported sector size 1.
> Oct 17 21:37:07 oscar kernel: SCSI device sda: 0 1-byte hdwr sectors (0 MB)

Yes. Reverting the 2.5.43 patch on usb/storage fixes this.

> Also attempting to rmmod usb-storage gets:
> 
> Oct 17 21:53:12 oscar kernel: kernel BUG at drivers/base/core.c:269!

Yes. I have seen the patch several times on this list.
See http://marc.theaimsgroup.com/?l=linux-kernel&m=103479992624108&w=2

Andries
