Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316884AbSEWQLK>; Thu, 23 May 2002 12:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316934AbSEWQLJ>; Thu, 23 May 2002 12:11:09 -0400
Received: from mail.gmx.de ([213.165.64.20]:64552 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S316884AbSEWQLI>;
	Thu, 23 May 2002 12:11:08 -0400
Message-ID: <3CED068A.870BC1D8@gmx.net>
Date: Thu, 23 May 2002 17:11:06 +0200
From: Gunther Mayer <gunther.mayer@gmx.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: Greg KH <greg@kroah.com>, linux-usb-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Linux-usb-users@lists.sourceforge.net
Subject: Re: [Linux-usb-users] Re: What to do with all of the USB UHCI driversin 
 the kernel?
In-Reply-To: <Pine.LNX.4.44.0205230746500.1824-100000@router-273.sgowdy.org> <3CECFBEE.9010802@evision-ventures.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dalecki wrote:

> Uz.ytkownik Stephen J. Gowdy napisa?:
> > Hi Martin,
> >       What do you actually want to know? That an EHCI controller should
> > use the ehci-hcd driver and that the OHCI controller should use the
> > ohci-hcd controller? Or that the uhci-* drivers can't drive a EHCI or OHCI
> > controller? Or something else?
>

Rename the old driver to *-old.
Rename the new drivers to the "normal" names.

There is no reason to confurce the userbase to fiddle
with their configurations. You said the old drivers could
seamlessly be replacedby s.th. better, so this policy will
implement this at it's best.

You will immediately get a lot of testing !!!

Regards, Gunther




