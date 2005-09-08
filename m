Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932517AbVIHOy5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932517AbVIHOy5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 10:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932519AbVIHOy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 10:54:57 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:34778 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932517AbVIHOy5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 10:54:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IccDd+oa5uieuooxUdNCmHm5nZIdrFH+9BoPU/CtRJG6sT86H+2YU3hzPBbGT2jsFy8QyO1ynbJCPJTKbjJ/26iLxU85f386wwt/XA4MbrI6olqPTm3asxIn8bpUSr1sUF7uoh0AqXTmfD3VMJ/KAxrRY7FfFsdi+PyIqG39X0M=
Message-ID: <d120d500050908075446a4c9e0@mail.gmail.com>
Date: Thu, 8 Sep 2005 09:54:33 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Eric Piel <Eric.Piel@lifl.fr>
Subject: Re: [DRIVER] Where is the PSX Gamepad Driver in 2.6.13-rc3?
Cc: Christoph Litters <christophlitters@gmx.de>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <43204DD4.3090103@lifl.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <42E48CA5.9010709@m1k.net> <43201906.8040902@gmx.de>
	 <d120d500050908073942876de5@mail.gmail.com> <43204DD4.3090103@lifl.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/05, Eric Piel <Eric.Piel@lifl.fr> wrote:
> 09/08/2005 04:38 PM, Dmitry Torokhov wrote/a écrit:
> > On 9/8/05, Christoph Litters <christophlitters@gmx.de> wrote:
> >
> >>Hello,
> >>
> >>I have an adapter usb to psx i have tried it with 2.6.9 and it works
> >>perfectly with the kernel driver.
> >>with 2.6.12 i cant get it to work and with 2.6.13-rc3 i havent seen any
> >>option to enable it.
> >>could anybody help me?
> >>
> >
> >
> > Device Drivers  ---> Input device support  ---> Joysticks  --->
> > Multisystem, NES, SNES, N64, PSX joysticks and gamepads
> >
> > Needs parport support.
> >
> 
> Are you sure? Isn't this only for parallel to psx adapters? Christoph
> says he has a "usb to psx" adapter.
> 

Oh, yes, sorry. In that case wouldn't HID driver handle it?

-- 
Dmitry
