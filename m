Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285226AbRLFVbQ>; Thu, 6 Dec 2001 16:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285227AbRLFVbF>; Thu, 6 Dec 2001 16:31:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:32609 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S285223AbRLFVa6>;
	Thu, 6 Dec 2001 16:30:58 -0500
Date: Thu, 6 Dec 2001 22:30:50 +0100
From: Rene Rebe <rene.rebe@gmx.net>
To: Jonathan Hudson <jonathan@daria.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Q: device(file) permissions for USB
Message-Id: <20011206223050.179cd30e.rene.rebe@gmx.net>
In-Reply-To: <664.3c0fd1b7.a66fa@trespassersw.daria.co.uk>
In-Reply-To: <fa.ljcupnv.1ghotjk@ifi.uio.no>
	<664.3c0fd1b7.a66fa@trespassersw.daria.co.uk>
Organization: FreeSourceCommunity ;-)
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Dec 2001 20:14:47 GMT
Jonathan Hudson <jonathan@daria.co.uk> wrote:

> In article <fa.ljcupnv.1ghotjk@ifi.uio.no>,
> 	kees <kees@schoen.nl> writes:
> k>   This message is in MIME format.  The first part should be readable text,
> k>   while the remaining parts are likely unreadable without MIME-aware tools.
> k>   Send mail to mime@docserver.cac.washington.edu for more info.
> k> 
> k> ---1463801846-915869288-1007668919=:13843
> k> Content-Type: TEXT/PLAIN; charset=US-ASCII
> k> 
> k> Hi,
> k> 
> k> I have been playing with an USB camera. I've run into the following
> k> problem:
> k> The (default?) permissions for /proc/bus/usb/001/011 (and others) are
> k> 0644. This makes the ioctl (see attached trace to fail). So I have to:
> k> either chmod the usb device file each time I unplug and replug the camera
> k> OR make the pencam program SUID root, which is neither comfortable.
> k> Is there a way to affect the default permissions for the USB devices?
> 
> Use hotplug to run a script to change the permissions when the device
> is connected. Mail me off list for an example.

This is what I do - but IT SUCKS!! Can't the USB stuff simply use devfs so
I can control the permissions of this USB nodes in a very nice / cleaner
way I do with all my other stuff??? (In contrast to use some find -name
| xargs chmod ... or simillar hacks ...)

Please

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


k33p h4ck1n6
  René

-- 
René Rebe (Registered Linux user: #248718 <http://counter.li.org>)

eMail:    rene.rebe@gmx.net
          rene@rocklinux.org

Homepage: http://www.tfh-berlin.de/~s712059/index.html

Anyone sending unwanted advertising e-mail to this address will be
charged $25 for network traffic and computing time. By extracting my
address from this message or its header, you agree to these terms.
