Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263326AbSKTXfR>; Wed, 20 Nov 2002 18:35:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263333AbSKTXfR>; Wed, 20 Nov 2002 18:35:17 -0500
Received: from mail.gmx.de ([213.165.64.20]:23618 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S263326AbSKTXfQ>;
	Wed, 20 Nov 2002 18:35:16 -0500
From: Felix Seeger <felix.seeger@gmx.de>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Subject: Re: 2.5.48 QM_MODULES: Function not implemented
Date: Thu, 21 Nov 2002 00:42:17 +0100
User-Agent: KMail/1.5
References: <200211202004.20261.felix.seeger@gmx.de> <3DDBF02D.4060005@iinet.net.au> <3DDC0AC8.9070308@nortelnetworks.com>
In-Reply-To: <3DDC0AC8.9070308@nortelnetworks.com>
Cc: linux-kernel@vger.kernel.org, Nero <neroz@iinet.net.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200211210042.17225.felix.seeger@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch 20 November 2002 23:20 schrieb Chris Friesen:
> Nero wrote:
> > Felix Seeger wrote:
> >  > I can't load a module, I get this: modprobe: Can't open dependencies
> >  > file /lib/modules/2.5.48/modules.dep ...
> >  >
> >  > depmod: QM_MODULES: Function not implemented
> >  >
> >  > I enabled all option in the module config.
> >
> > You need Rusty's modutils from here:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/rusty/modules/module-init-to
> >ols-0.7.tar.bz2
>
> Rusty's stuff will let you load, but you'll still get the depmod error.
>   It would have been nice to have a version of depmod that does nothing
> normally but calls the old version on an older kernel.
>
> Chris

Maybe it is normal but this doesn't fix the depmod problem even with the new 
kernel, I have modprobe, rmod and so back but the package doesn't include 
depmod.

I am running debian unstable, many install scripts uses parameters that are 
not provided by this version (I think -l and -r).
Maybe this is only for debian so I have to wait for a patched package...

Is it a bug that all modules are in the same dir without subdirs ? It is hard 
to find them.

thanks
have fun
Felix
