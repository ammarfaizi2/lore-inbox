Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262279AbUFJScG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262279AbUFJScG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 14:32:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262337AbUFJScG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 14:32:06 -0400
Received: from [212.69.243.51] ([212.69.243.51]:16910 "HELO linuxoutlaws.co.uk")
	by vger.kernel.org with SMTP id S262279AbUFJScC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 14:32:02 -0400
Date: Thu, 10 Jun 2004 19:30:19 +0100
From: Rob Shakir <lkml@rshk.co.uk>
To: Dan Hollis <goemon@anime.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: random fs corruption with iriver ihp-120, usb2, vfat and 2.6.5
Message-ID: <20040610183019.GA9780@rshk.co.uk>
References: <Pine.LNX.4.44.0406100516440.31443-100000@sasami.anime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0406100516440.31443-100000@sasami.anime.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2004 at 05:25:17AM -0700, Dan Hollis wrote:
> 
> I guess I'm seeing the same corruption as reported in this thread:
> http://www.mail-archive.com/linux-usb-users@lists.sourceforge.net/msg10327.html
> 
> If I copy large files to this device and then read it back, I always 
> get different md5sums. And random filesystem corruption.

I've experienced this problem too, do you find that the device works almost
perfectly if the data is tranferred in smaller blocks?

> 
> I've learned that the drive in this device, a Toshiba MK2004GAL is 
> connected directly to the usb2.0 via a cypress CY7C68310:
> http://www.cypress.com/products/datasheet.cfm?partnum=CY7C68310
>

I tried to find out some information from iRiver before bug reporting this, I
didn't know whether the bug was specifically with my device. However, I found
the tech support department to be fairly atrocious. 

Now that I know it's not something that's device centred I may try taking a look
at the bug (although I'm not experienced at all in this area of the kernel).

~rob

