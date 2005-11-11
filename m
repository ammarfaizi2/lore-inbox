Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751220AbVKKAVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbVKKAVp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 19:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbVKKAVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 19:21:45 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:54916
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1751220AbVKKAVo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 19:21:44 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Gustavo Guillermo =?iso-8859-15?q?P=E9rez?= 
	<gustavo@compunauta.com>
Subject: Re: 2.6.14, udev: unknown symbols for ehci_hcd
Date: Thu, 10 Nov 2005 18:20:18 -0600
User-Agent: KMail/1.8
Cc: Harald Dunkel <harald.dunkel@t-online.de>, linux-kernel@vger.kernel.org
References: <436CD1BC.8020102@t-online.de> <436D9BDE.3060404@t-online.de> <200511061103.14850.gustavo@compunauta.com>
In-Reply-To: <200511061103.14850.gustavo@compunauta.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200511101820.21276.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 06 November 2005 11:03, Gustavo Guillermo Pérez wrote:
> El Sábado, 5 de Noviembre de 2005 23:59, escribió:
> > Greg KH wrote:
> > > On Sat, Nov 05, 2005 at 04:37:32PM +0100, Harald Dunkel wrote:
> > >>Hi folks,
> > >>
> > >>I can't say since when this problem is in, but currently
> > >>I get error messages about unknown symbols at boot time
> > >>(after mounting the root disk, as it seems):
> > >
> > > Are you using Debian?
> >
> > Of course :=)
>
> I was having that problem using busybox insmod, changing to latest kernel
> tools was fixed for me, I don't know why, but in my case was a ramdisk to
> load sata drivers before mounting the root disk. Anyway module-init-tools
> is not too bigger even building them with glibc instead uClibc as static
> binaries.
>
> :)

Which version of busybox?  (If something's wrong with it, I'm interested in 
fixing it.  Insmod underwent a lot of changes to support 2.6, and it took a 
while to stabilize again...)

Rob
