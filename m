Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262646AbSJTN4N>; Sun, 20 Oct 2002 09:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262648AbSJTN4N>; Sun, 20 Oct 2002 09:56:13 -0400
Received: from tomts12.bellnexxia.net ([209.226.175.56]:34039 "EHLO
	tomts12-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S262646AbSJTN4M>; Sun, 20 Oct 2002 09:56:12 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Andries Brouwer <aebr@win.tue.nl>
Subject: Re: usb storage sddr09
Date: Sun, 20 Oct 2002 09:52:23 -0400
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
References: <200210172155.49349.tomlins@cam.org> <20021018193523.GA25316@win.tue.nl>
In-Reply-To: <20021018193523.GA25316@win.tue.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210200952.23430.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On October 18, 2002 03:35 pm, Andries Brouwer wrote:
> On Thu, Oct 17, 2002 at 09:55:49PM -0400, Ed Tomlinson wrote:
> > In the patch fest in the last couple of days usb storage support for
> > sddr09 has broken.  I see the following in the log (2.5.43-mm2):
> >
> > Oct 17 21:37:07 oscar kernel: sddr09: Found Flash card, ID = 00 00 00 00:
> > Manuf. unknown, 4096 MB Oct 17 21:37:07 oscar kernel: sda : unsupported
> > sector size 1.
> > Oct 17 21:37:07 oscar kernel: SCSI device sda: 0 1-byte hdwr sectors (0
> > MB)
>
> Yes. Reverting the 2.5.43 patch on usb/storage fixes this.
>
> > Also attempting to rmmod usb-storage gets:
> >
> > Oct 17 21:53:12 oscar kernel: kernel BUG at drivers/base/core.c:269!
>
> Yes. I have seen the patch several times on this list.
> See http://marc.theaimsgroup.com/?l=linux-kernel&m=103479992624108&w=2

Both of these are fixed with 2.4.44

Thanks
Ed Tomlinson
