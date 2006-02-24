Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932571AbWBXERR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932571AbWBXERR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 23:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932574AbWBXERR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 23:17:17 -0500
Received: from xenotime.net ([66.160.160.81]:40113 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932571AbWBXERQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 23:17:16 -0500
Date: Thu, 23 Feb 2006 20:18:23 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: patrakov@ums.usu.ru, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: zcat: stdin: decompression OK (was: Re: 2.6.16-rc4-mm1)
Message-Id: <20060223201823.35eaee2d.rdunlap@xenotime.net>
In-Reply-To: <20060223182107.GB7803@mipter.zuzino.mipt.ru>
References: <20060220042615.5af1bddc.akpm@osdl.org>
	<43FC6B8F.4060601@ums.usu.ru>
	<20060222225325.10a71472.rdunlap@xenotime.net>
	<20060223182107.GB7803@mipter.zuzino.mipt.ru>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Feb 2006 21:21:07 +0300 Alexey Dobriyan wrote:

> On Wed, Feb 22, 2006 at 10:53:25PM -0800, Randy.Dunlap wrote:
> > On Wed, 22 Feb 2006 18:47:59 +0500 Alexander E. Patrakov wrote:
> > > Unfortunately, I lost my .config from the old kernel, so I attempted the
> > > following:
> > >
> > > cd scripts
> > > make binoffset
> > > cd ..
> > > scripts/extract-ikconfig /boot/vmlinuz-2.6.16-rc3-mm1-home >.config
> > >
> > > This results in:
> > >
> > > zcat: stdin: decompression OK, trailing garbage ignored
> >
> > No other output?  what $ARCH?
> > What did the .config file contain?  was it correct?
> > so is the only problem the zcat warning message?
> >
> > I tested extract-ikconfig several times without errors (on 2.6.16-rc4-mm1).
> 
> Since I can reproduce it, Randy, what version do you use? 1.3.5-r8 here
> from Gentoo.
> 
> At least, we can trivially shut it up.

Hi Alexey-

zcat 1.3.5
(2002-09-30)

---
~Randy
