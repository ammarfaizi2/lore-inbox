Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267228AbTBIMxT>; Sun, 9 Feb 2003 07:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267229AbTBIMxT>; Sun, 9 Feb 2003 07:53:19 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:13577 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267228AbTBIMxS>;
	Sun, 9 Feb 2003 07:53:18 -0500
Date: Sun, 9 Feb 2003 04:57:59 -0800
From: Greg KH <greg@kroah.com>
To: Alex Riesen <alexander.riesen@synopsys.COM>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
       hpa@zytor.com, Russell King <rmk@arm.linux.org.uk>
Subject: Re: [RFC] klibc for 2.5.59 bk
Message-ID: <20030209125759.GA14981@kroah.com>
References: <20030207045919.GA30526@kroah.com> <20030207150038.GM5239@riesen-pc.gr05.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030207150038.GM5239@riesen-pc.gr05.synopsys.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 07, 2003 at 04:00:38PM +0100, Alex Riesen wrote:
> Greg KH, Fri, Feb 07, 2003 05:59:19 +0100:
> > Hi all,
> > 
> > Thanks to Arnd Bergmann, it looks like the klibc and initramfs code is
> > now working.  I've created a patch against Linus's latest bk tree and
> > put it at:
> > 	http://www.kroah.com/linux/klibc/klibc-2.5.59-2.patch.gz
> 
> was the following part of the patch intended? (hello_world?)

Yes it was.  It shows how to add a binary file to the initramfs image,
and have it executed by the kernel during the early boot process.

The fact that the program didn't really do anything significant isn't
important here.

thanks,

greg k-h
