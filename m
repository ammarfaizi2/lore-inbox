Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932152AbVKFRDT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbVKFRDT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 12:03:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932155AbVKFRDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 12:03:19 -0500
Received: from compunauta.com ([69.36.170.169]:27629 "EHLO compunauta.com")
	by vger.kernel.org with ESMTP id S932152AbVKFRDS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 12:03:18 -0500
From: Gustavo Guillermo =?iso-8859-15?q?P=E9rez?= 
	<gustavo@compunauta.com>
Organization: www.compunauta.com
To: Harald Dunkel <harald.dunkel@t-online.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.14, udev: unknown symbols for ehci_hcd
Date: Sun, 6 Nov 2005 11:03:14 -0600
User-Agent: KMail/1.8.2
References: <436CD1BC.8020102@t-online.de> <20051105162503.GC20686@kroah.com> <436D9BDE.3060404@t-online.de>
In-Reply-To: <436D9BDE.3060404@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200511061103.14850.gustavo@compunauta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Sábado, 5 de Noviembre de 2005 23:59, escribió:
> Greg KH wrote:
> > On Sat, Nov 05, 2005 at 04:37:32PM +0100, Harald Dunkel wrote:
> >>Hi folks,
> >>
> >>I can't say since when this problem is in, but currently
> >>I get error messages about unknown symbols at boot time
> >>(after mounting the root disk, as it seems):
> >
> > Are you using Debian?
>
> Of course :=)

I was having that problem using busybox insmod, changing to latest kernel 
tools was fixed for me, I don't know why, but in my case was a ramdisk to 
load sata drivers before mounting the root disk. Anyway module-init-tools is 
not too bigger even building them with glibc instead uClibc as static 
binaries.

:)
-- 
Gustavo Guillermo Pérez
Compunauta uLinux
www.compunauta.com
